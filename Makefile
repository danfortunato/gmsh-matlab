MEX        ?= mex
GMSH_INC   ?=
GMSH_LIB   ?=
GMSH_SRC   ?= ../gmsh

INTERNAL   := +gmsh/+internal
MEXFLAGS   := -R2018a$(if $(GMSH_INC), -I$(GMSH_INC)) -I$(INTERNAL)$(if $(GMSH_LIB), -L$(GMSH_LIB)) -lgmsh
MEXNAME    := gmsh_mex
GEN_SCRIPT := gen/gen_matlab.py
GEN_SPEC   := $(GMSH_SRC)/api/gen.py $(GMSH_SRC)/api/GenApi.py

.PHONY: mex gen test clean help

mex: $(INTERNAL)/$(MEXNAME).mex*

gen:
	@GMSH_SRC=$(GMSH_SRC) python3 $(GEN_SCRIPT)

$(INTERNAL)/$(MEXNAME).c: $(GEN_SCRIPT) $(GEN_SPEC)
	@GMSH_SRC=$(GMSH_SRC) python3 $(GEN_SCRIPT)

$(INTERNAL)/$(MEXNAME).mex*: $(INTERNAL)/$(MEXNAME).c $(INTERNAL)/callbacks.c $(INTERNAL)/callbacks.h
	$(MEX) $(MEXFLAGS) -outdir $(INTERNAL) -output $(MEXNAME) $(INTERNAL)/$(MEXNAME).c $(INTERNAL)/callbacks.c

# Run every tutorial / example port through the diff harness. Each port
# prints its own status (RAN/IDENTICAL/CLOSE/DIFFER); `make test` exits
# non-zero if any port returned non-zero. Set GMSH_SRC to enable
# byte-comparison against the upstream Python wrapper (requires a python3
# on PATH with `pip install gmsh`); otherwise the harness runs MATLAB-only
# and just verifies each port exits 0.
test: $(INTERNAL)/$(MEXNAME).mex*
	@fail=0; \
	for f in tutorials/*.m examples/api/*.m; do \
	    gen/validate.sh "$$(basename "$$f" .m)" || fail=1; \
	done; \
	exit $$fail

clean:
	rm -f $(INTERNAL)/*.mex*

help:
	@echo "Usage:"
	@echo "  make              Build the MEX binary."
	@echo "  make gen          Regenerate the MATLAB API interface."
	@echo "  make test         Verify that the MATLAB API matches the Gmsh Python API."
	@echo "  make clean        Remove the MEX binary."
	@echo "  make help         Show this message."
