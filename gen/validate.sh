#!/bin/bash
#
# validate.sh NAME [RTOL]
#
# Run a MATLAB port from this repo (tutorials/<NAME>.m or examples/api/<NAME>.m)
# in a sandbox, optionally compare its output against the upstream Python
# reference in a separate sandbox.
#
# Modes (selected automatically by which env vars are set):
#
#   * MATLAB-only mode (default): run the .m port, report PASS/FAIL on exit.
#     No Python comparison.
#
#   * Diff mode: also run the upstream Python script and byte-compare every
#     produced output file. Bytes-differ files are re-checked with numerical
#     tolerance (see numdiff.py); RTOL=0 forces strict byte equality.
#
#     Enable diff mode by setting GMSH_SRC to a gmsh source clone. The
#     harness invokes `python3` from PATH, so activate a venv with
#     `pip install gmsh` (or otherwise ensure `python3` can `import gmsh`)
#     before running.
#
# Exit status:
#   0   ran cleanly; every common output (if any) is byte-identical
#   1   diff mode: at least one common file is neither identical nor close
#   2   missing input
#   3   diff mode: one side produced an output file the other did not
#   4/5 python/matlab failed to run
#   6   diff mode: at least one file is only CLOSE (no DIFFER, no MISSING)

set -eu
name="${1:?usage: validate.sh NAME [RTOL]}"
rtol="${2:-1e-12}"
HERE=$(cd "$(dirname "$0")" && pwd)
PKG=$(cd "$HERE/.." && pwd)

# Optional: enable byte-diff against the upstream Python reference by
# pointing GMSH_SRC at a gmsh source clone. python3 from PATH is used to
# run the Python side, so activate a venv with `pip install gmsh` first.
GMSH_SRC="${GMSH_SRC:-}"

# Convenience: auto-discover the in-tree sibling layout.
if [ -z "$GMSH_SRC" ] && [ -d "$PKG/../gmsh" ]; then
    GMSH_SRC="$PKG/../gmsh"
fi

diff_mode=0
if [ -n "$GMSH_SRC" ]; then
    diff_mode=1
fi

# Locate the .m port. Examples whose names collide with MATLAB built-ins
# (view, open, spline, partition, simple, boolean, test, normals, volume)
# are prefixed with `ex_`; their Python counterparts keep the upstream name.
pyname="$name"
case "$name" in
    ex_*) pyname="${name#ex_}" ;;
esac
mlpath=""; pypath=""; src_assets=""
if [ -f "$PKG/tutorials/${name}.m" ]; then
    mlpath="$PKG/tutorials/${name}.m"
    pypath="$GMSH_SRC/tutorials/python/${pyname}.py"
    src_assets="$GMSH_SRC/tutorials"
elif [ -f "$PKG/examples/api/${name}.m" ]; then
    mlpath="$PKG/examples/api/${name}.m"
    pypath="$GMSH_SRC/examples/api/${pyname}.py"
    src_assets="$GMSH_SRC/examples/api"
else
    echo "MISSING ${name}.m (looked in tutorials/ and examples/api/)" >&2; exit 2
fi
if [ $diff_mode -eq 1 ] && [ ! -f "$pypath" ]; then
    echo "MISSING $pypath (diff mode but no Python reference)" >&2; exit 2
fi

mlcmd="/Applications/MATLAB_${MATLAB_VERSION:-R2025b}.app/bin/matlab"

mldir=$(mktemp -d)
pydir=""
if [ $diff_mode -eq 1 ]; then
    pydir=$(mktemp -d)
fi
trap 'rm -rf "$mldir" ${pydir:+"$pydir"}' EXIT

# Stage data assets that the script reads (only meaningful in diff mode,
# where the upstream gmsh source tree has the shared assets).
stage_assets() {
    local dest="$1"
    case "$src_assets" in
        */tutorials)
            for asset in "$src_assets"/${name}_* "$src_assets"/view*.pos; do
                [ -e "$asset" ] && cp "$asset" "$dest/"
            done
            ;;
        */examples/api)
            for asset in "$src_assets"/*; do
                [ -f "$asset" ] || continue
                case "$asset" in
                    *.py|*.cpp|*.cc|*.c|*.h|*.hpp|*.jl|*.f90|*.f95|*.go|*.cs|*.m|*.mat|*CMakeLists.txt) continue ;;
                esac
                cp "$asset" "$dest/"
            done
            ;;
    esac
}

if [ $diff_mode -eq 1 ]; then
    stage_assets "$pydir"
    stage_assets "$mldir"
else
    # MATLAB-only mode: stage from the in-repo copies next to the .m port
    # (tutorials/ or examples/api/ themselves carry the data files).
    mlpath_dir=$(dirname "$mlpath")
    for asset in "$mlpath_dir"/*; do
        [ -f "$asset" ] || continue
        case "$asset" in
            *.m) continue ;;
        esac
        cp "$asset" "$mldir/"
    done
fi

cp "$mlpath" "$mldir/${name}.m"

# Always run MATLAB.
cd "$mldir"
if ! "$mlcmd" -batch "addpath('$PKG'); addpath('$mldir'); addpath('$(dirname "$mlpath")'); $name" > "$mldir/run.log" 2>&1; then
    echo "[$name] matlab failed"; tail -20 "$mldir/run.log"; exit 5
fi

if [ $diff_mode -eq 0 ]; then
    echo "[$name] RAN"
    exit 0
fi

# Diff mode: also run Python.
cd "$pydir"
if ! python3 "$pypath" -nopopup > "$pydir/run.log" 2>&1; then
    echo "[$name] python failed"; tail -20 "$pydir/run.log"; exit 4
fi

# Collect output filenames (everything except our own logs and the staged inputs).
ignore() {
    case "$1" in
        run.log|"${name}.m"|"${name}.py") return 0 ;;
    esac
    [ -f "$src_assets/$1" ] && return 0
    return 1
}

cd "$pydir"; pyouts=()
for f in *; do [ -f "$f" ] && ! ignore "$f" && pyouts+=("$f"); done
cd "$mldir"; mlouts=()
for f in *; do [ -f "$f" ] && ! ignore "$f" && mlouts+=("$f"); done

all=$(printf '%s\n' "${pyouts[@]:-}" "${mlouts[@]:-}" | sort -u | sed '/^$/d')

if [ -z "$all" ]; then
    echo "[$name] RAN (no output files to diff)"
    exit 0
fi

ndiff=0; nmiss=0; nok=0; nclose=0
for f in $all; do
    if [ ! -f "$pydir/$f" ]; then
        echo "[$name] MISSING-IN-PYTHON: $f"
        nmiss=$((nmiss + 1))
        continue
    fi
    if [ ! -f "$mldir/$f" ]; then
        echo "[$name] MISSING-IN-MATLAB: $f"
        nmiss=$((nmiss + 1))
        continue
    fi
    if diff -q "$pydir/$f" "$mldir/$f" > /dev/null; then
        nok=$((nok + 1))
        continue
    fi
    if [ "$rtol" != "0" ] && \
       python3 "$HERE/numdiff.py" "$pydir/$f" "$mldir/$f" "$rtol" > "$mldir/${f}.numdiff" 2>&1; then
        info=$(cat "$mldir/${f}.numdiff" || true)
        echo "[$name] CLOSE: $f (rtol=$rtol${info:+; $info})"
        nclose=$((nclose + 1))
    else
        echo "[$name] DIFFER: $f"
        sed 's/^/  /' "$mldir/${f}.numdiff" 2>/dev/null | head -5 || true
        ndiff=$((ndiff + 1))
    fi
done

if [ $nmiss -gt 0 ]; then exit 3; fi
if [ $ndiff -gt 0 ]; then exit 1; fi
if [ $nclose -gt 0 ]; then
    echo "[$name] CLOSE ($nok identical, $nclose close, rtol=$rtol)"
    exit 6
fi
echo "[$name] IDENTICAL ($nok file(s))"
exit 0
