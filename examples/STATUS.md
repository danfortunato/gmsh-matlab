# Example port status (MEX binding)

Every example in `gmsh/examples/api/*.py` that translates cleanly to MATLAB
has a port in [api/](api/). `gen/validate.sh <name>` runs both, then
compares every output file with byte-equality first, falling back to
numerical tolerance (default `rtol = 1e-12`) for any text diffs.

## Coverage

| | Count |
|---|---|
| Python source files | 89 |
| Skipped (Python-specific facilities) | 4 |
| Ported to MATLAB | **85** |

### Skipped examples (genuinely non-portable)

| Python script | Why we skipped |
|---|---|
| `multi_process.py` | Uses Python's `multiprocessing.Process` to spawn N independent gmsh processes. MATLAB's `parpool` semantics differ enough that a direct port would mislead more than it would help. |
| `custom_gui.py` | Uses Python `threading.Thread` to update an FLTK custom GUI in real time while computation runs. MATLAB's threading model doesn't have a comparable pattern. |
| `onelab_run.py` | Uses Python `threading.Thread` to run two concurrent GetDP solver clients communicating with the ONELAB server. |
| `onelab_run_auto.py` | Requires the GetDP external solver binary in PATH. No portability issue per se, but the example fails the same way in both Python and MATLAB without GetDP installed. |

### Filename renames (avoid shadowing MATLAB built-ins)

Nine example .m files were prefixed with `ex_` to prevent shadowing core
MATLAB or toolbox functions when `addpath('gmsh_mex/examples/api')` is
called:

| Python | MATLAB |
|---|---|
| `view.py` | `ex_view.m` (avoids shadowing `view(az, el)`) |
| `open.py` | `ex_open.m` (avoids shadowing `open(filename)`) |
| `spline.py` | `ex_spline.m` (avoids shadowing `spline(x, y, xx)`) |
| `partition.py` | `ex_partition.m` (avoids shadowing Parallel Computing Toolbox `partition`) |
| `test.py` | `ex_test.m` (avoids shadowing test framework names) |
| `boolean.py` | `ex_boolean.m` (avoids deprecated `logical()` alias) |
| `simple.py` | `ex_simple.m` (avoids deprecated Symbolic `simplify()` alias) |
| `normals.py` | `ex_normals.m` (defensive — toolbox property names) |
| `volume.py` | `ex_volume.m` (defensive) |

`gen/validate.sh` automatically strips the `ex_` prefix when locating
the matching `.py` file.

## Known issues that affect specific examples

The harness reports four examples as non-trivially differing from Python.
None are binding bugs; each is a known environmental or design limit.

### macOS OpenMP runtime conflict

| Example | Status |
|---|---|
| `multi_thread.m` | matlab segfault |
| `raw_tetrahedralization.m` | matlab segfault |

MATLAB ships Intel's `libiomp5.dylib` and preloads it. Gmsh links its own
`libomp.dylib`. When either example sets `General.NumThreads > 1` or
selects `Mesh.Algorithm3D = 10` (the OMP-parallel HXT algorithm),
`pthread_mutex_init` fails with `EINVAL` and gmsh segfaults. The Python
version runs fine because Python doesn't preload an OpenMP runtime.

Workaround: launch the standalone `gmsh` binary on the produced model
when you want to exercise these paths.

### Stateful-script artifacts

| Example | Status |
|---|---|
| `ex_test.m` | both sides fail on first run |

`test.py` does `gmsh.open("square.msh")` before creating any geometry —
it only works on a re-run, where the previous invocation wrote
`square.msh`. Our port wraps the open in try/catch but the Python script
crashes unconditionally on the first run.

### Vector-layout mismatch

| Example | Status |
|---|---|
| `import_perf.m` | bytes differ; same mesh |

The Python version uses numpy's row-major `meshgrid` + `stack` to build
its coordinate buffer; the MATLAB port builds the same conceptual mesh
but with MATLAB's column-major layout, producing a different node
ordering. The resulting `.msh` files are semantically equivalent (same
node count, same triangulation), just with different node-tag ordering.

## What the rest of the suite looks like

Most of the 85 ports either run cleanly with no diffable output (post-
processing / GUI-driven examples) or produce identical `.msh` / `.pos`
files. The split is dominated by RAN (interactive examples whose Python
counterparts also emit no comparable files under `-nopopup`), with a
handful that write `.msh` or `.pos` and end up byte-identical with
Python.

To re-run the suite from scratch:

```sh
ls gmsh_mex/examples/api/*.m | sed 's|.*/||; s|\.m$||' | \
  while read n; do gmsh_mex/gen/validate.sh "$n"; done
```
