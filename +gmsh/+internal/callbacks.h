#ifndef GMSH_MEX_CALLBACKS_H
#define GMSH_MEX_CALLBACKS_H

#include "mex.h"

/* Install (or clear, if fn is NULL/empty) a MATLAB function handle as the
 * size callback. Forwards to gmshModelMeshSetSizeCallback; the returned
 * value is gmsh's ierr (0 on success). */
int gmsh_mex_install_size_callback(const mxArray *fn);

/* Free any persistent callback state. Registered with mexAtExit by the
 * dispatcher on first invocation. Safe to call multiple times. */
void gmsh_mex_clear_callbacks(void);

#endif
