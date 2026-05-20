#!/usr/bin/env python3
"""Generate the +gmsh MATLAB package and the matching MEX dispatcher.

We monkey-patch GenApi's input/output factories so each `arg` carries a
semantic `matlab_kind` tag, then exec gmsh/api/gen.py to populate the spec.
For every emitted gmsh function we write two artifacts:

  * gmsh_mex/+gmsh/.../<func>.m   - thin wrapper with arguments-block
                                    validation, forwards to the MEX.
  * a `static void wrap_<symbol>` in gmsh_mex/+gmsh/+internal/gmsh_mex.c, plus an
    entry in the dispatch table.

The .m wrappers do *only* shape validation (via the arguments block) and
forwarding; all numeric coercion happens in C.

While the binding is still under construction the `WHITELIST` constant
restricts emission to the subset of functions needed for the t1 tutorial.
Set WHITELIST=None (or empty) to emit every gmsh API entry.
"""

from __future__ import annotations

import importlib.util
import os
import re
import shutil
import sys
import textwrap
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
_GMSH_SRC_ENV = os.environ.get("GMSH_SRC")
GMSH_SRC = Path(_GMSH_SRC_ENV).resolve() if _GMSH_SRC_ENV else (ROOT.parent / "gmsh").resolve()
GMSH_API_DIR = GMSH_SRC / "api"
PKG_ROOT = ROOT / "+gmsh"
SRC_DIR = ROOT / "+gmsh" / "+internal"
GENERATED_C = SRC_DIR / "gmsh_mex.c"

sys.path.insert(0, str(GMSH_API_DIR))
import GenApi  # noqa: E402


# ---------------------------------------------------------------------------
# Monkey-patch GenApi so each `arg` instance is tagged with its matlab_kind.
# ---------------------------------------------------------------------------

INPUT_FACTORIES = (
    "ibool", "iint", "isize", "idouble", "istring", "ivoidstar",
    "ivectorint", "ivectorsize", "ivectordouble", "ivectorstring",
    "ivectorpair", "ivectorvectorint", "ivectorvectorsize",
    "ivectorvectordouble",
    "ostring", "ovectorint", "ovectorsize", "ovectordouble",
    "ovectorstring", "ovectorpair", "ovectorvectorint",
    "ovectorvectorsize", "ovectorvectordouble", "ovectorvectorpair",
    "iargcargv", "isizefun",
)


def _tag_factory(kind, original):
    def wrapped(*args, **kwargs):
        a = original(*args, **kwargs)
        a.matlab_kind = kind
        return a
    return wrapped


for _fname in INPUT_FACTORIES:
    setattr(GenApi, _fname, _tag_factory(_fname, getattr(GenApi, _fname)))


def _patch_class(cls_name):
    cls = getattr(GenApi, cls_name)
    orig_init = cls.__init__

    def __init__(self, *args, **kwargs):
        orig_init(self, *args, **kwargs)
        self.matlab_kind = cls_name

    cls.__init__ = __init__


for _cls_name in ("oint", "osize", "odouble"):
    _patch_class(_cls_name)


def _load_api_spec():
    gen_path = GMSH_API_DIR / "gen.py"
    spec = importlib.util.spec_from_file_location("gmsh_gen_spec", gen_path)
    mod = importlib.util.module_from_spec(spec)
    old_cwd = os.getcwd()
    os.chdir(GMSH_API_DIR)
    try:
        spec.loader.exec_module(mod)
    finally:
        os.chdir(old_cwd)
    return mod.api


# ---------------------------------------------------------------------------
# Bootstrap whitelist: only emit these functions while the generator is being
# built out. Set to None once every matlab_kind is implemented in C.
# ---------------------------------------------------------------------------

WHITELIST = None  # emit every gmsh API function


# ---------------------------------------------------------------------------
# Reserved MATLAB names to avoid shadowing inside the wrappers / arguments.
# We keep the existing binding's wider rename list so user-facing parameter
# names match the calllib version exactly.
# ---------------------------------------------------------------------------

_MATLAB_NAME_REMAP = {
    "error":    "errMsg",
    "end":      "endIdx",
    "class":    "cls",
    "function": "func",
    "return":   "ret_val",
    "size":     "sz",
    "length":   "len",
    "numel":    "n_",
    "type":     "kind",
    "i":        "ix",
    "j":        "jx",
}


def _safe_matlab_name(name):
    return _MATLAB_NAME_REMAP.get(name, name)


# ---------------------------------------------------------------------------
# MATLAB default value rendering.
# ---------------------------------------------------------------------------

def _matlab_default(arg):
    """Render the spec's Python-flavoured default literal as MATLAB."""
    pv = getattr(arg, "python_value", None) or arg.value
    if pv is None:
        return None
    pv = pv.strip()
    if pv == "True":
        return "true"
    if pv == "False":
        return "false"
    if pv == '""':
        return "''"
    if pv == "[]":
        # The MATLAB-side type depends on the kind; we override below.
        return "[]"
    return pv


# ---------------------------------------------------------------------------
# Per-kind metadata.
#
# Each entry tells the generator:
#   matlab_param  - True if the kind contributes one positional arg to the
#                   MATLAB signature (False for iargcargv and the output-only
#                   kinds oint/osize/odouble/o*).
#   plhs          - True if this kind produces a MATLAB return value.
#   validator     - arguments-block validator string (when matlab_param).
#   default_kind  - how to specialise `[]` defaults (e.g. int32([]) for
#                   ivectorint).
#   doc_type      - human-readable type for the docstring.
# ---------------------------------------------------------------------------

KIND_INFO = {
    "ibool":       dict(validator="(1,1) logical", doc_type="logical scalar"),
    "iint":        dict(validator="(1,1) {mustBeInteger}", doc_type="integer scalar"),
    "isize":       dict(validator="(1,1) {mustBeInteger, mustBeNonnegative}", doc_type="size_t scalar"),
    "idouble":     dict(validator="(1,1) double", doc_type="double scalar"),
    "istring":     dict(validator="(1,:) char", doc_type="string"),
    "ivoidstar":   dict(validator="", doc_type="void* (uint64 address)"),
    "ivectorint":      dict(validator="", doc_type="vector of integers",
                            default_override={"[]": "int32([])"}),
    "ivectorsize":     dict(validator="", doc_type="vector of size_t",
                            default_override={"[]": "uint64([])"}),
    "ivectordouble":   dict(validator="", doc_type="vector of doubles",
                            default_override={"[]": "[]"}),
    "ivectorstring":   dict(validator="", doc_type="cell of strings",
                            default_override={"[]": "{}"}),
    "ivectorpair":     dict(validator="", doc_type="Nx2 matrix of (dim,tag)",
                            default_override={"[]": "zeros(0,2)"}),
    "ivectorvectorint":    dict(validator="", doc_type="cell of integer vectors",
                                default_override={"[]": "{}"}),
    "ivectorvectorsize":   dict(validator="", doc_type="cell of size_t vectors",
                                default_override={"[]": "{}"}),
    "ivectorvectordouble": dict(validator="", doc_type="cell of double vectors",
                                default_override={"[]": "{}"}),
    "iargcargv":   dict(suppress=True),
    "isizefun":    dict(validator="(1,1) function_handle", doc_type="function handle"),
    # Output kinds — no MATLAB input, contribute one plhs.
    "oint":              dict(plhs=True, doc_type="integer scalar"),
    "osize":             dict(plhs=True, doc_type="size_t scalar"),
    "odouble":           dict(plhs=True, doc_type="double scalar"),
    "ostring":           dict(plhs=True, doc_type="string"),
    "ovectorint":        dict(plhs=True, doc_type="row vector of int32"),
    "ovectorsize":       dict(plhs=True, doc_type="row vector of uint64"),
    "ovectordouble":     dict(plhs=True, doc_type="row vector of doubles"),
    "ovectorstring":     dict(plhs=True, doc_type="cell of strings"),
    "ovectorpair":       dict(plhs=True, doc_type="Nx2 matrix of (dim,tag) pairs"),
    "ovectorvectorint":    dict(plhs=True, doc_type="cell of int32 row vectors"),
    "ovectorvectorsize":   dict(plhs=True, doc_type="cell of uint64 row vectors"),
    "ovectorvectordouble": dict(plhs=True, doc_type="cell of double row vectors"),
    "ovectorvectorpair":   dict(plhs=True, doc_type="cell of Nx2 (dim,tag) matrices"),
}


def _rtype_kind(rtype):
    """rtype may be a class (oint/osize/odouble) or an instance — handle both."""
    if rtype is None:
        return None
    return getattr(rtype, "matlab_kind", None) or rtype.__name__


def _is_matlab_param(kind):
    info = KIND_INFO[kind]
    if info.get("suppress"):
        return False
    if info.get("plhs"):
        return False
    return True


def _is_plhs(kind):
    return KIND_INFO[kind].get("plhs", False)


# ---------------------------------------------------------------------------
# C-side emission per matlab_kind.
#
# Each block returns a dict with:
#   locals_decl  : C code declaring locals before the gmsh call
#   pre_call     : C code populating those locals from prhs (input) or
#                  preparing scratch storage (output).
#   call_args    : list of C expressions to splice into the gmsh function call.
#   post_call    : C code after the gmsh call (cleanup of input scratch,
#                  conversion of output scratch to mxArray held in
#                  out_<idx>, etc.).
#   plhs_expr    : C expression for the mxArray to place into plhs[i].
# `i` is the 0-based MATLAB-input index (used for prhs[i] reads); for
# output-only kinds it's unused. `o` is the 0-based plhs index.
# ---------------------------------------------------------------------------

def _emit_scalar_in(c_local, name, kind, i):
    cast = {
        "ibool":   ("int",    "as_bool_scalar"),
        "iint":    ("int",    "as_int_scalar"),
        "isize":   ("size_t", "as_size_scalar"),
        "idouble": ("double", "as_double_scalar"),
    }[kind]
    return {
        "locals_decl": f"    {cast[0]} {c_local};\n",
        "pre_call":    f'    {c_local} = {cast[1]}(prhs[{i}], "{name}");\n',
        "call_args":   [c_local],
        "post_call":   "",
        "plhs_expr":   None,
    }


def _emit_istring(c_local, name, i):
    return {
        "locals_decl": f"    char *{c_local} = NULL;\n",
        "pre_call":    f'    {c_local} = as_cstring(prhs[{i}], "{name}");\n',
        "call_args":   [c_local],
        "post_call":   f"    if ({c_local}) mxFree({c_local});\n",
        "plhs_expr":   None,
    }


def _emit_ivoidstar(c_local, name, i):
    return {
        "locals_decl": f"    void *{c_local} = NULL;\n",
        "pre_call":    f'    {c_local} = (void *)(uintptr_t)as_size_scalar(prhs[{i}], "{name}");\n',
        "call_args":   [c_local],
        "post_call":   "",
        "plhs_expr":   None,
    }


def _emit_iargcargv(c_local):
    return {
        "locals_decl": (f"    int {c_local}_argc = 0;\n"
                        f"    char **{c_local}_argv = NULL;\n"),
        "pre_call":    "",
        "call_args":   [f"{c_local}_argc", f"{c_local}_argv"],
        "post_call":   "",
        "plhs_expr":   None,
    }


def _emit_ivectorint(c_local, name, i):
    return {
        "locals_decl": (f"    int *{c_local} = NULL;\n"
                        f"    size_t {c_local}_n = 0;\n"),
        "pre_call":    f'    {c_local} = as_int_vec(prhs[{i}], &{c_local}_n, "{name}");\n',
        "call_args":   [c_local, f"{c_local}_n"],
        "post_call":   f"    if ({c_local}) mxFree({c_local});\n",
        "plhs_expr":   None,
    }


def _emit_ivectorsize(c_local, name, i):
    return {
        "locals_decl": (f"    size_t *{c_local} = NULL;\n"
                        f"    size_t {c_local}_n = 0;\n"),
        "pre_call":    f'    {c_local} = as_size_vec(prhs[{i}], &{c_local}_n, "{name}");\n',
        "call_args":   [c_local, f"{c_local}_n"],
        "post_call":   f"    if ({c_local}) mxFree({c_local});\n",
        "plhs_expr":   None,
    }


def _emit_ivectordouble(c_local, name, i):
    return {
        "locals_decl": (f"    double *{c_local} = NULL;\n"
                        f"    size_t {c_local}_n = 0;\n"),
        "pre_call":    f'    {c_local} = as_double_vec(prhs[{i}], &{c_local}_n, "{name}");\n',
        "call_args":   [c_local, f"{c_local}_n"],
        "post_call":   f"    if ({c_local}) mxFree({c_local});\n",
        "plhs_expr":   None,
    }


def _emit_ivectorpair(c_local, name, i):
    return {
        "locals_decl": (f"    int *{c_local} = NULL;\n"
                        f"    size_t {c_local}_n = 0;\n"),
        "pre_call":    f'    {c_local} = as_pair_vec(prhs[{i}], &{c_local}_n, "{name}");\n',
        "call_args":   [c_local, f"{c_local}_n"],
        "post_call":   f"    if ({c_local}) mxFree({c_local});\n",
        "plhs_expr":   None,
    }


def _emit_ivectorstring(c_local, name, i):
    return {
        "locals_decl": (f"    char **{c_local} = NULL;\n"
                        f"    size_t {c_local}_n = 0;\n"),
        "pre_call":    f'    {c_local} = as_cstring_vec(prhs[{i}], &{c_local}_n, "{name}");\n',
        # gmsh declares this `const char *const *`. The cast acknowledges that
        # promise; we keep the local writable so we can free the strings.
        "call_args":   [f"(const char *const *){c_local}", f"{c_local}_n"],
        "post_call":   f"    free_cstring_vec({c_local}, {c_local}_n);\n",
        "plhs_expr":   None,
    }


def _emit_ivectorvector(c_local, name, i, elem_c_type, helper):
    return {
        "locals_decl": (f"    {elem_c_type} **{c_local} = NULL;\n"
                        f"    size_t *{c_local}_n = NULL;\n"
                        f"    size_t {c_local}_nn = 0;\n"),
        "pre_call":    f'    {c_local} = {helper}(prhs[{i}], &{c_local}_n, &{c_local}_nn, "{name}");\n',
        # gmsh declares the data and sizes pointers as deeply-const; cast to
        # the matching const-qualified shape at the call site. We keep the
        # locals writable so post-call cleanup can free them.
        "call_args":   [f"(const {elem_c_type} *const *){c_local}",
                        f"(const size_t *){c_local}_n",
                        f"{c_local}_nn"],
        "post_call":   f"    free_nested({c_local}, {c_local}_n, {c_local}_nn);\n",
        "plhs_expr":   None,
    }


def _emit_isizefun(c_local, name, i):
    # gmshModelMeshSetSizeCallback's signature is special: the C wrapper has
    # to bridge through the persistent handle, not pass a raw function ptr.
    # We encode this inline; the wrapper function body must include a call
    # to gmsh_mex_install_size_callback instead of the gmsh function.
    return {
        "locals_decl": "",
        "pre_call":    "",
        "call_args":   [],   # special-cased by render_c_wrapper
        "post_call":   "",
        "plhs_expr":   None,
        "special":     "isizefun",
    }


# Scalar output (rtype or out-arg).
def _emit_oint(c_local, o):
    return {
        "locals_decl": f"    int {c_local} = 0;\n",
        "pre_call":    "",
        "call_args":   [f"&{c_local}"],
        "post_call":   "",
        "plhs_expr":   f"mxCreateDoubleScalar((double){c_local})",
    }


def _emit_osize(c_local, o):
    return {
        "locals_decl": f"    size_t {c_local} = 0;\n",
        "pre_call":    "",
        "call_args":   [f"&{c_local}"],
        "post_call":   "",
        "plhs_expr":   f"mxCreateDoubleScalar((double){c_local})",
    }


def _emit_odouble(c_local, o):
    return {
        "locals_decl": f"    double {c_local} = 0.0;\n",
        "pre_call":    "",
        "call_args":   [f"&{c_local}"],
        "post_call":   "",
        "plhs_expr":   f"mxCreateDoubleScalar({c_local})",
    }


def _emit_ostring(c_local, o):
    return {
        "locals_decl": f"    char *{c_local} = NULL;\n",
        "pre_call":    "",
        "call_args":   [f"&{c_local}"],
        "post_call":   (f"    mxArray *m_{c_local} = mxCreateString({c_local} ? {c_local} : \"\");\n"
                        f"    if ({c_local}) gmshFree({c_local});\n"),
        "plhs_expr":   f"m_{c_local}",
    }


def _emit_ovec(c_local, o, kind):
    builder = {
        "ovectorint":    "make_and_free_int_row",
        "ovectorsize":   "make_and_free_size_row",
        "ovectordouble": "make_and_free_double_row",
        "ovectorpair":   "make_and_free_pair_matrix",
    }[kind]
    return {
        "locals_decl": (f"    void *p_{c_local} = NULL;\n"
                        f"    size_t n_{c_local} = 0;\n"),
        "pre_call":    "",
        "call_args":   [f"(void*)&p_{c_local}", f"&n_{c_local}"],
        "post_call":   f"    mxArray *m_{c_local} = {builder}(&p_{c_local}, n_{c_local});\n",
        "plhs_expr":   f"m_{c_local}",
    }


def _emit_ovecstring(c_local, o):
    return {
        "locals_decl": (f"    char **p_{c_local} = NULL;\n"
                        f"    size_t n_{c_local} = 0;\n"),
        "pre_call":    "",
        "call_args":   [f"&p_{c_local}", f"&n_{c_local}"],
        "post_call":   f"    mxArray *m_{c_local} = make_and_free_cellstr(&p_{c_local}, n_{c_local});\n",
        "plhs_expr":   f"m_{c_local}",
    }


def _emit_ovecvec(c_local, o, kind):
    builder = {
        "ovectorvectorint":    "make_and_free_nested_int_row",
        "ovectorvectorsize":   "make_and_free_nested_size_row",
        "ovectorvectordouble": "make_and_free_nested_double_row",
        "ovectorvectorpair":   "make_and_free_nested_pair_matrix",
    }[kind]
    return {
        "locals_decl": (f"    void *p_{c_local} = NULL;\n"
                        f"    size_t *pn_{c_local} = NULL;\n"
                        f"    size_t nn_{c_local} = 0;\n"),
        "pre_call":    "",
        "call_args":   [f"(void*)&p_{c_local}", f"&pn_{c_local}", f"&nn_{c_local}"],
        "post_call":   f"    mxArray *m_{c_local} = {builder}(&p_{c_local}, &pn_{c_local}, nn_{c_local});\n",
        "plhs_expr":   f"m_{c_local}",
    }


def emit_for_arg(arg, in_idx, out_idx):
    """Dispatch to the per-kind emitter; return the snippet dict."""
    kind = arg.matlab_kind
    name = arg.name
    c_local = f"a_{name}"
    if kind in ("ibool", "iint", "isize", "idouble"):
        return _emit_scalar_in(c_local, name, kind, in_idx)
    if kind == "istring":
        return _emit_istring(c_local, name, in_idx)
    if kind == "ivoidstar":
        return _emit_ivoidstar(c_local, name, in_idx)
    if kind == "iargcargv":
        return _emit_iargcargv(c_local)
    if kind == "ivectorint":
        return _emit_ivectorint(c_local, name, in_idx)
    if kind == "ivectorsize":
        return _emit_ivectorsize(c_local, name, in_idx)
    if kind == "ivectordouble":
        return _emit_ivectordouble(c_local, name, in_idx)
    if kind == "ivectorpair":
        return _emit_ivectorpair(c_local, name, in_idx)
    if kind == "ivectorstring":
        return _emit_ivectorstring(c_local, name, in_idx)
    if kind == "ivectorvectorint":
        return _emit_ivectorvector(c_local, name, in_idx, "int", "as_nested_int")
    if kind == "ivectorvectorsize":
        return _emit_ivectorvector(c_local, name, in_idx, "size_t", "as_nested_size")
    if kind == "ivectorvectordouble":
        return _emit_ivectorvector(c_local, name, in_idx, "double", "as_nested_double")
    if kind == "isizefun":
        return _emit_isizefun(c_local, name, in_idx)
    if kind == "oint":
        return _emit_oint(c_local, out_idx)
    if kind == "osize":
        return _emit_osize(c_local, out_idx)
    if kind == "odouble":
        return _emit_odouble(c_local, out_idx)
    if kind == "ostring":
        return _emit_ostring(c_local, out_idx)
    if kind in ("ovectorint", "ovectorsize", "ovectordouble", "ovectorpair"):
        return _emit_ovec(c_local, out_idx, kind)
    if kind == "ovectorstring":
        return _emit_ovecstring(c_local, out_idx)
    if kind in ("ovectorvectorint", "ovectorvectorsize",
                "ovectorvectordouble", "ovectorvectorpair"):
        return _emit_ovecvec(c_local, out_idx, kind)
    raise NotImplementedError(f"matlab_kind {kind!r} not yet supported")


def emit_rtype(rtype):
    """Return a snippet dict for an oint/osize/odouble return type.

    rtype's C call is `<type> ret_ = gmshFoo(...)`; nothing goes in
    call_args because rtype isn't a parameter.
    """
    if rtype is None:
        return None
    kind = _rtype_kind(rtype)
    if kind == "oint":
        return {
            "locals_decl": "",
            "pre_call":    "",
            "call_args":   [],
            "post_call":   "",
            "ret_c_type":  "int",
            "plhs_expr":   "mxCreateDoubleScalar((double)ret_)",
        }
    if kind == "osize":
        return {
            "locals_decl": "",
            "pre_call":    "",
            "call_args":   [],
            "post_call":   "",
            "ret_c_type":  "size_t",
            "plhs_expr":   "mxCreateDoubleScalar((double)ret_)",
        }
    if kind == "odouble":
        return {
            "locals_decl": "",
            "pre_call":    "",
            "call_args":   [],
            "post_call":   "",
            "ret_c_type":  "double",
            "plhs_expr":   "mxCreateDoubleScalar(ret_)",
        }
    raise NotImplementedError(f"return matlab_kind {kind!r} not supported")


# ---------------------------------------------------------------------------
# C wrapper rendering.
# ---------------------------------------------------------------------------

def render_c_wrapper(c_symbol, args, rtype, qualified_path):
    """Render the C `static void wrap_<sym>(...)` function body."""
    rconv = emit_rtype(rtype)
    # First pass: figure out indices and snippets.
    in_idx = 0
    out_idx = 0
    snippets = []
    for a in args:
        kind = a.matlab_kind
        if KIND_INFO[kind].get("suppress"):
            snip = emit_for_arg(a, in_idx, out_idx)
        elif _is_plhs(kind):
            snip = emit_for_arg(a, in_idx, out_idx)
            out_idx += 1
        else:
            snip = emit_for_arg(a, in_idx, out_idx)
            in_idx += 1
        snippets.append((a, snip))
    expected_nrhs = sum(
        1 for a in args
        if not KIND_INFO[a.matlab_kind].get("suppress")
        and not _is_plhs(a.matlab_kind)
    )

    out = []
    out.append(f"static void wrap_{c_symbol}(int nlhs, mxArray *plhs[],")
    out.append(f"                              int nrhs, const mxArray *prhs[]) {{")
    out.append(f'    if (nrhs != {expected_nrhs}) mexErrMsgIdAndTxt(ERRID_BADCALL,')
    out.append(f'        "{c_symbol}: expected {expected_nrhs} args, got %d", nrhs);')

    # Locals declarations.
    for a, snip in snippets:
        if snip["locals_decl"]:
            out.append(snip["locals_decl"].rstrip("\n"))
    out.append("    int ierr = 0;")

    # Pre-call statements.
    for a, snip in snippets:
        if snip["pre_call"]:
            out.append(snip["pre_call"].rstrip("\n"))

    # Build call args list.
    call_args = []
    for a, snip in snippets:
        call_args.extend(snip["call_args"])
    call_args.append("&ierr")

    # Special-case: isizefun (only one function uses it; bypass the normal
    # call path and route through the persistent-handle bridge).
    is_size_cb = any(getattr(s, "special", None) == "isizefun"
                     or s.get("special") == "isizefun"
                     for _, s in snippets)
    if is_size_cb:
        # The MATLAB function handle is the first MATLAB input (in_idx 0).
        out.append("    ierr = gmsh_mex_install_size_callback(prhs[0]);")
    else:
        prefix = ""
        if rconv is not None:
            out.append(f"    {rconv['ret_c_type']} ret_ = 0;")
            prefix = "ret_ = "
        out.append(f"    {prefix}{c_symbol}({', '.join(call_args)});")

    # Error check (skip for gmshLoggerGetLastError to avoid recursion).
    if c_symbol != "gmshLoggerGetLastError":
        out.append("    raise_if_ierr(ierr);")

    # Post-call statements.
    for a, snip in snippets:
        if snip["post_call"]:
            out.append(snip["post_call"].rstrip("\n"))

    # plhs assembly. Order: rtype (if any) first, then output args in spec
    # order.
    plhs_idx = 0
    if rconv is not None:
        out.append(f"    if (nlhs > {plhs_idx}) plhs[{plhs_idx}] = {rconv['plhs_expr']};")
        plhs_idx += 1
    for a, snip in snippets:
        if snip.get("plhs_expr"):
            out.append(f"    if (nlhs > {plhs_idx}) plhs[{plhs_idx}] = {snip['plhs_expr']};")
            plhs_idx += 1

    # Special handling for ostring/getLastError: if no consumer, free the
    # buffer. The mxCreateString already happened in post_call and stored
    # the C buffer; this path is fine.
    out.append("}")
    out.append("")
    return "\n".join(out)


# ---------------------------------------------------------------------------
# C dispatcher prologue (helpers + mexFunction).
# ---------------------------------------------------------------------------

C_PROLOGUE = r"""/* gmsh_mex.c - GENERATED by gen_matlab.py. Do not edit by hand. */

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "mex.h"
#include "gmshc.h"
#include "callbacks.h"

#define ERRID_BADCALL  "gmsh:badCall"
#define ERRID_BADARG   "gmsh:badArg"
#define ERRID_APIERR   "gmsh:apiError"

/* ---------- input scalar marshallers ---------- */

static int as_bool_scalar(const mxArray *a, const char *name) {
    if (!a || mxGetNumberOfElements(a) != 1 ||
        (!mxIsLogicalScalar(a) && !mxIsNumeric(a)))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected logical/numeric scalar", name);
    return mxGetScalar(a) != 0.0 ? 1 : 0;
}

static int as_int_scalar(const mxArray *a, const char *name) {
    if (!a || mxGetNumberOfElements(a) != 1 || !mxIsNumeric(a))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected numeric scalar", name);
    return (int)mxGetScalar(a);
}

static size_t as_size_scalar(const mxArray *a, const char *name) {
    if (!a || mxGetNumberOfElements(a) != 1 || !mxIsNumeric(a))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected numeric scalar", name);
    double d = mxGetScalar(a);
    if (d < 0) mexErrMsgIdAndTxt(ERRID_BADARG, "%s: must be nonnegative", name);
    return (size_t)d;
}

static double as_double_scalar(const mxArray *a, const char *name) {
    if (!a || mxGetNumberOfElements(a) != 1 || !mxIsNumeric(a))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected numeric scalar", name);
    return mxGetScalar(a);
}

static char *as_cstring(const mxArray *a, const char *name) {
    if (mxIsChar(a)) return mxArrayToUTF8String(a);
    mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected char vector", name);
    return NULL;
}

/* ---------- input vector marshallers ---------- */

/* Copy any numeric MATLAB vector to a fresh int* (mxMalloc'd). */
static int *as_int_vec(const mxArray *a, size_t *n_out, const char *name) {
    if (mxIsEmpty(a)) { *n_out = 0; return NULL; }
    if (!mxIsNumeric(a) && !mxIsLogical(a))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected numeric vector", name);
    size_t n = mxGetNumberOfElements(a);
    *n_out = n;
    int *out = (int *)mxMalloc(n * sizeof(int));
    if (mxIsInt32(a)) {
        const int32_T *src = (const int32_T *)mxGetData(a);
        for (size_t i = 0; i < n; ++i) out[i] = (int)src[i];
    } else if (mxIsDouble(a)) {
        const double *src = mxGetDoubles(a);
        for (size_t i = 0; i < n; ++i) out[i] = (int)src[i];
    } else {
        mxArray *cast = NULL, *args[1] = {(mxArray*)a};
        if (mexCallMATLAB(1, &cast, 1, args, "double") != 0)
            mexErrMsgIdAndTxt(ERRID_BADARG, "%s: cannot cast to double", name);
        const double *src = mxGetDoubles(cast);
        for (size_t i = 0; i < n; ++i) out[i] = (int)src[i];
        mxDestroyArray(cast);
    }
    return out;
}

static size_t *as_size_vec(const mxArray *a, size_t *n_out, const char *name) {
    if (mxIsEmpty(a)) { *n_out = 0; return NULL; }
    if (!mxIsNumeric(a) && !mxIsLogical(a))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected numeric vector", name);
    size_t n = mxGetNumberOfElements(a);
    *n_out = n;
    size_t *out = (size_t *)mxMalloc(n * sizeof(size_t));
    if (mxIsUint64(a)) {
        const uint64_T *src = (const uint64_T *)mxGetData(a);
        for (size_t i = 0; i < n; ++i) out[i] = (size_t)src[i];
    } else if (mxIsDouble(a)) {
        const double *src = mxGetDoubles(a);
        for (size_t i = 0; i < n; ++i) out[i] = (size_t)src[i];
    } else {
        mxArray *cast = NULL, *args[1] = {(mxArray*)a};
        if (mexCallMATLAB(1, &cast, 1, args, "double") != 0)
            mexErrMsgIdAndTxt(ERRID_BADARG, "%s: cannot cast to double", name);
        const double *src = mxGetDoubles(cast);
        for (size_t i = 0; i < n; ++i) out[i] = (size_t)src[i];
        mxDestroyArray(cast);
    }
    return out;
}

static double *as_double_vec(const mxArray *a, size_t *n_out, const char *name) {
    if (mxIsEmpty(a)) { *n_out = 0; return NULL; }
    if (!mxIsNumeric(a) && !mxIsLogical(a))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected numeric vector", name);
    size_t n = mxGetNumberOfElements(a);
    *n_out = n;
    double *out = (double *)mxMalloc(n * sizeof(double));
    if (mxIsDouble(a)) {
        memcpy(out, mxGetDoubles(a), n * sizeof(double));
    } else {
        mxArray *cast = NULL, *args[1] = {(mxArray*)a};
        if (mexCallMATLAB(1, &cast, 1, args, "double") != 0)
            mexErrMsgIdAndTxt(ERRID_BADARG, "%s: cannot cast to double", name);
        memcpy(out, mxGetDoubles(cast), n * sizeof(double));
        mxDestroyArray(cast);
    }
    return out;
}

/* Nx2 (dim,tag) matrix -> interleaved int32[2*N]. n_out = 2*N. */
static int *as_pair_vec(const mxArray *a, size_t *n_out, const char *name) {
    if (mxIsEmpty(a)) { *n_out = 0; return NULL; }
    if (mxGetN(a) != 2)
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected Nx2 (dim,tag) matrix", name);
    size_t N = mxGetM(a);
    *n_out = 2 * N;
    int *out = (int *)mxMalloc(2 * N * sizeof(int));
    /* MATLAB is column-major: column 0 = dims, column 1 = tags. */
    if (mxIsInt32(a)) {
        const int32_T *src = (const int32_T *)mxGetData(a);
        for (size_t i = 0; i < N; ++i) {
            out[2*i + 0] = (int)src[i];
            out[2*i + 1] = (int)src[N + i];
        }
    } else if (mxIsDouble(a)) {
        const double *src = mxGetDoubles(a);
        for (size_t i = 0; i < N; ++i) {
            out[2*i + 0] = (int)src[i];
            out[2*i + 1] = (int)src[N + i];
        }
    } else {
        mxArray *cast = NULL, *args[1] = {(mxArray*)a};
        if (mexCallMATLAB(1, &cast, 1, args, "double") != 0)
            mexErrMsgIdAndTxt(ERRID_BADARG, "%s: cannot cast to double", name);
        const double *src = mxGetDoubles(cast);
        for (size_t i = 0; i < N; ++i) {
            out[2*i + 0] = (int)src[i];
            out[2*i + 1] = (int)src[N + i];
        }
        mxDestroyArray(cast);
    }
    return out;
}

/* Cell of char vectors -> char** + count. */
static char **as_cstring_vec(const mxArray *a, size_t *n_out, const char *name) {
    if (mxIsEmpty(a)) { *n_out = 0; return NULL; }
    if (!mxIsCell(a))
        mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected cell array of strings", name);
    size_t n = mxGetNumberOfElements(a);
    *n_out = n;
    char **out = (char **)mxMalloc(n * sizeof(char *));
    for (size_t i = 0; i < n; ++i) {
        mxArray *e = mxGetCell(a, i);
        if (!e || !mxIsChar(e))
            mexErrMsgIdAndTxt(ERRID_BADARG, "%s[%zu]: expected char vector", name, i);
        out[i] = mxArrayToUTF8String(e);
    }
    return out;
}

static void free_cstring_vec(char **v, size_t n) {
    if (!v) return;
    for (size_t i = 0; i < n; ++i) if (v[i]) mxFree(v[i]);
    mxFree(v);
}

/* Cell of numeric vectors -> T** + size_t* sizes + outer count. */
static int **as_nested_int(const mxArray *a, size_t **inner_n, size_t *outer_n, const char *name) {
    if (!mxIsCell(a)) mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected cell array", name);
    size_t nn = mxGetNumberOfElements(a);
    *outer_n = nn;
    if (nn == 0) { *inner_n = NULL; return NULL; }
    int **data = (int **)mxMalloc(nn * sizeof(int *));
    size_t *sizes = (size_t *)mxMalloc(nn * sizeof(size_t));
    for (size_t i = 0; i < nn; ++i) {
        size_t ni = 0;
        data[i] = as_int_vec(mxGetCell(a, i), &ni, name);
        sizes[i] = ni;
    }
    *inner_n = sizes;
    return data;
}

static size_t **as_nested_size(const mxArray *a, size_t **inner_n, size_t *outer_n, const char *name) {
    if (!mxIsCell(a)) mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected cell array", name);
    size_t nn = mxGetNumberOfElements(a);
    *outer_n = nn;
    if (nn == 0) { *inner_n = NULL; return NULL; }
    size_t **data = (size_t **)mxMalloc(nn * sizeof(size_t *));
    size_t *sizes = (size_t *)mxMalloc(nn * sizeof(size_t));
    for (size_t i = 0; i < nn; ++i) {
        size_t ni = 0;
        data[i] = as_size_vec(mxGetCell(a, i), &ni, name);
        sizes[i] = ni;
    }
    *inner_n = sizes;
    return data;
}

static double **as_nested_double(const mxArray *a, size_t **inner_n, size_t *outer_n, const char *name) {
    if (!mxIsCell(a)) mexErrMsgIdAndTxt(ERRID_BADARG, "%s: expected cell array", name);
    size_t nn = mxGetNumberOfElements(a);
    *outer_n = nn;
    if (nn == 0) { *inner_n = NULL; return NULL; }
    double **data = (double **)mxMalloc(nn * sizeof(double *));
    size_t *sizes = (size_t *)mxMalloc(nn * sizeof(size_t));
    for (size_t i = 0; i < nn; ++i) {
        size_t ni = 0;
        data[i] = as_double_vec(mxGetCell(a, i), &ni, name);
        sizes[i] = ni;
    }
    *inner_n = sizes;
    return data;
}

#define DEFINE_FREE_NESTED(T, fname)                                    \
static void fname(T **data, size_t *sizes, size_t nn) {                 \
    if (data) {                                                         \
        for (size_t i = 0; i < nn; ++i) if (data[i]) mxFree(data[i]);   \
        mxFree(data);                                                   \
    }                                                                   \
    if (sizes) mxFree(sizes);                                           \
}
DEFINE_FREE_NESTED(int,    free_nested_int)
DEFINE_FREE_NESTED(size_t, free_nested_size)
DEFINE_FREE_NESTED(double, free_nested_double)
/* Generic dispatch for free_nested: each emitter passes the same args, so a
 * macro-overloaded name isn't quite right; we use _Generic. */
#define free_nested(d, s, nn) _Generic((d),                             \
    int **:    free_nested_int,                                         \
    size_t **: free_nested_size,                                        \
    double **: free_nested_double                                       \
)((d), (s), (nn))

/* ---------- output marshallers (gmsh-allocated -> mxArray, freeing buffer) ---------- */

static mxArray *make_and_free_int_row(void **pp, size_t n) {
    mxArray *m = mxCreateNumericMatrix(n > 0 ? 1 : 0, n, mxINT32_CLASS, mxREAL);
    if (n > 0) {
        int *src = *(int **)pp;
        int32_T *dst = (int32_T *)mxGetData(m);
        for (size_t i = 0; i < n; ++i) dst[i] = (int32_T)src[i];
        gmshFree(src);
    } else if (*(void **)pp) {
        gmshFree(*(void **)pp);
    }
    return m;
}

static mxArray *make_and_free_size_row(void **pp, size_t n) {
    mxArray *m = mxCreateNumericMatrix(n > 0 ? 1 : 0, n, mxUINT64_CLASS, mxREAL);
    if (n > 0) {
        size_t *src = *(size_t **)pp;
        uint64_T *dst = (uint64_T *)mxGetData(m);
        for (size_t i = 0; i < n; ++i) dst[i] = (uint64_T)src[i];
        gmshFree(src);
    } else if (*(void **)pp) {
        gmshFree(*(void **)pp);
    }
    return m;
}

static mxArray *make_and_free_double_row(void **pp, size_t n) {
    mxArray *m = mxCreateDoubleMatrix(n > 0 ? 1 : 0, n, mxREAL);
    if (n > 0) {
        double *src = *(double **)pp;
        memcpy(mxGetDoubles(m), src, n * sizeof(double));
        gmshFree(src);
    } else if (*(void **)pp) {
        gmshFree(*(void **)pp);
    }
    return m;
}

/* Interleaved [d0,t0,d1,t1,...] -> Nx2 int32 matrix. n is 2*N. */
static mxArray *make_and_free_pair_matrix(void **pp, size_t n) {
    size_t N = n / 2;
    mxArray *m = mxCreateNumericMatrix(N, 2, mxINT32_CLASS, mxREAL);
    if (n > 0) {
        int *src = *(int **)pp;
        int32_T *dst = (int32_T *)mxGetData(m);
        /* column-major: col 0 = dims (even indices), col 1 = tags (odd). */
        for (size_t i = 0; i < N; ++i) {
            dst[i]     = (int32_T)src[2*i + 0];
            dst[N + i] = (int32_T)src[2*i + 1];
        }
        gmshFree(src);
    } else if (*(void **)pp) {
        gmshFree(*(void **)pp);
    }
    return m;
}

static mxArray *make_and_free_cellstr(char ***pp, size_t n) {
    mxArray *m = mxCreateCellMatrix(n > 0 ? 1 : 0, n);
    if (n > 0) {
        char **src = *pp;
        for (size_t i = 0; i < n; ++i) {
            mxSetCell(m, i, mxCreateString(src[i] ? src[i] : ""));
            if (src[i]) gmshFree(src[i]);
        }
        gmshFree(src);
    } else if (*pp) {
        gmshFree(*pp);
    }
    return m;
}

/* Nested outputs: gmsh allocates outer T**, separate size_t* sizes, and each
 * inner T*. We free all of them after copying. */
#define DEFINE_MAKE_NESTED_ROW(T, fname, mkrow)                          \
static mxArray *fname(void **pp_outer, size_t **pp_sizes, size_t nn) {   \
    mxArray *m = mxCreateCellMatrix(nn > 0 ? 1 : 0, nn);                 \
    T **outer = *(T ***)pp_outer;                                        \
    size_t *sizes = *pp_sizes;                                           \
    for (size_t i = 0; i < nn; ++i) {                                    \
        T *row = outer ? outer[i] : NULL;                                \
        size_t ni = sizes ? sizes[i] : 0;                                \
        void *rp = row;                                                  \
        mxSetCell(m, i, mkrow(&rp, ni));                                 \
    }                                                                    \
    if (outer) gmshFree(outer);                                          \
    if (sizes) gmshFree(sizes);                                          \
    return m;                                                            \
}
DEFINE_MAKE_NESTED_ROW(int,    make_and_free_nested_int_row,    make_and_free_int_row)
DEFINE_MAKE_NESTED_ROW(size_t, make_and_free_nested_size_row,   make_and_free_size_row)
DEFINE_MAKE_NESTED_ROW(double, make_and_free_nested_double_row, make_and_free_double_row)
DEFINE_MAKE_NESTED_ROW(int,    make_and_free_nested_pair_matrix, make_and_free_pair_matrix)

/* ---------- error path ---------- */

static void raise_if_ierr(int ierr) {
    if (ierr == 0) return;
    char *msg = NULL; int dummy = 0;
    gmshLoggerGetLastError(&msg, &dummy);
    char buf[2048];
    snprintf(buf, sizeof buf, "%s",
             (msg && msg[0]) ? msg : "gmsh API error");
    if (msg) gmshFree(msg);
    mexErrMsgIdAndTxt(ERRID_APIERR, "%s", buf);
}

"""

C_MEX_FUNCTION_TEMPLATE = r"""
/* ---------- dispatcher ---------- */

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    static int atexit_registered = 0;
    if (!atexit_registered) {
        mexAtExit(gmsh_mex_clear_callbacks);
        atexit_registered = 1;
    }
    if (nrhs < 1 || !mxIsChar(prhs[0]))
        mexErrMsgIdAndTxt(ERRID_BADCALL, "first arg must be a C symbol name string");
    char *sym = mxArrayToUTF8String(prhs[0]);
__DISPATCH__
    {
        /* mexErrMsgIdAndTxt longjmps; mx-allocated `sym` is reclaimed by MATLAB. */
        mexErrMsgIdAndTxt("gmsh:unknownSymbol", "unknown gmsh symbol: %s", sym);
    }
}
"""


def render_dispatch_chain(symbols):
    """Emit an if/else if chain dispatching to each wrap_<symbol>."""
    lines = []
    for i, s in enumerate(symbols):
        kw = "if" if i == 0 else "else if"
        lines.append(f'    {kw} (!strcmp(sym, "{s}")) {{ mxFree(sym); wrap_{s}(nlhs, plhs, nrhs - 1, prhs + 1); return; }}')
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# .m wrapper rendering.
# ---------------------------------------------------------------------------

def render_m_wrapper(fname, args, rtype, doc, qualified):
    """Render the .m wrapper text for a single gmsh function."""
    # Inputs that show up in the MATLAB signature.
    in_params = []  # list of (matlab_name, kind, default, doc_type, validator)
    for a in args:
        kind = a.matlab_kind
        if KIND_INFO[kind].get("suppress") or _is_plhs(kind):
            continue
        info = KIND_INFO[kind]
        matlab_name = _safe_matlab_name(a.name)
        default = _matlab_default(a)
        if default == "[]" and "default_override" in info:
            default = info["default_override"]["[]"]
        in_params.append((matlab_name, kind, default,
                          info.get("doc_type", ""),
                          info.get("validator", "")))

    # Outputs. rtype first, then output args in spec order.
    out_names = []
    if rtype is not None:
        out_names.append("ret")
    for a in args:
        if _is_plhs(a.matlab_kind):
            out_names.append(_safe_matlab_name(a.name))

    in_names = [p[0] for p in in_params]
    if not out_names:
        sig = f"{fname}({', '.join(in_names)})"
    elif len(out_names) == 1:
        sig = f"{out_names[0]} = {fname}({', '.join(in_names)})"
    else:
        sig = f"[{', '.join(out_names)}] = {fname}({', '.join(in_names)})"

    lines = []
    lines.append(f"function {sig}")
    lines.append(f"%{fname.upper()}  {qualified}")
    for para in textwrap.wrap(doc, 76):
        lines.append(f"%   {para}")
    if in_params:
        lines.append("%")
        lines.append("%   Inputs:")
        for matlab_name, _kind, default, doc_type, _validator in in_params:
            d = f" (default {default})" if default is not None else ""
            lines.append(f"%     {matlab_name} - {doc_type}{d}")
    if out_names:
        lines.append("%")
        lines.append("%   Outputs:")
        if rtype is not None:
            rdoc = KIND_INFO[_rtype_kind(rtype)]["doc_type"]
            lines.append(f"%     ret - {rdoc}")
        for a in args:
            if _is_plhs(a.matlab_kind):
                lines.append(
                    f"%     {_safe_matlab_name(a.name)} - "
                    f"{KIND_INFO[a.matlab_kind]['doc_type']}")
    lines.append("")

    indent = "    "
    if in_params:
        lines.append(f"{indent}arguments")
        for matlab_name, _kind, default, _doc, validator in in_params:
            row = f"{indent}{indent}{matlab_name}"
            if validator:
                row += f" {validator}"
            if default is not None:
                row += f" = {default}"
            lines.append(row)
        lines.append(f"{indent}end")
        lines.append("")

    # Build the call(...) invocation. C symbol comes from the qualified path
    # plus the function name (camelCased).
    c_sym = c_symbol_for(qualified)
    call_args = ", ".join(["'" + c_sym + "'"] + in_names)
    if not out_names:
        lines.append(f"{indent}gmsh.internal.api.call({call_args});")
    elif len(out_names) == 1:
        lines.append(f"{indent}{out_names[0]} = gmsh.internal.api.call({call_args});")
    else:
        out_list = ", ".join(out_names)
        lines.append(f"{indent}[{out_list}] = gmsh.internal.api.call({call_args});")

    lines.append("end")
    return "\n".join(lines) + "\n"


def c_symbol_for(qualified):
    """Convert dotted gmsh path -> CamelCase C symbol.

    e.g. "gmsh.model.geo.addPoint" -> "gmshModelGeoAddPoint".
    """
    parts = qualified.split(".")
    head = parts[0]
    tail = "".join(p[0].upper() + p[1:] for p in parts[1:])
    return head + tail


# ---------------------------------------------------------------------------
# Walk the spec and emit everything.
# ---------------------------------------------------------------------------

def walk_modules(api):
    out = []  # list of (parts, module)
    def recurse(mod, parts):
        out.append((parts, mod))
        for sm in mod.submodules:
            recurse(sm, parts + [sm.name])
    for m in api.modules:
        recurse(m, [m.name])
    return out


def main():
    api = _load_api_spec()

    # Clean previously generated package directories (keep +internal).
    if PKG_ROOT.exists():
        for child in PKG_ROOT.iterdir():
            if child.name == "+internal":
                continue
            if child.is_dir() and child.name.startswith("+"):
                shutil.rmtree(child)
            elif child.is_file() and child.suffix == ".m":
                child.unlink()
    PKG_ROOT.mkdir(parents=True, exist_ok=True)
    SRC_DIR.mkdir(parents=True, exist_ok=True)

    emitted = []        # list of (qualified, c_symbol)
    skipped = []        # list of (qualified, reason)
    c_wrappers = []     # list of C wrapper strings

    for parts, module in walk_modules(api):
        for rtype, name, fargs, doc, special in module.fs:
            if any("onlycc" in s for s in special):
                continue
            slash_key = "/".join(list(parts) + [name])
            if WHITELIST is not None and slash_key not in WHITELIST:
                continue
            qualified = ".".join(parts + [name])
            try:
                c_sym = c_symbol_for(qualified)
                m_text = render_m_wrapper(name, fargs, rtype, doc, qualified)
                c_text = render_c_wrapper(c_sym, fargs, rtype, qualified)
            except NotImplementedError as exc:
                skipped.append((qualified, str(exc)))
                continue
            target_dir = ROOT / Path(*[f"+{p}" for p in parts])
            target_dir.mkdir(parents=True, exist_ok=True)
            (target_dir / f"{name}.m").write_text(m_text)
            emitted.append((qualified, c_sym))
            c_wrappers.append(c_text)

    # Stitch the C file together.
    sorted_symbols = [c for _, c in emitted]
    dispatch_block = render_dispatch_chain(sorted_symbols)
    parts = [C_PROLOGUE]
    parts.extend(c_wrappers)
    parts.append(C_MEX_FUNCTION_TEMPLATE.replace("__DISPATCH__", dispatch_block))
    GENERATED_C.write_text("".join(parts))

    print(f"Emitted {len(emitted)} functions; skipped {len(skipped)}.")
    if skipped:
        for q, r in skipped:
            print(f"  - {q}: {r}")


if __name__ == "__main__":
    main()
