#include "callbacks.h"
#include "gmshc.h"

static mxArray *g_size_callback_handle = NULL;

static double matlab_size_callback(int dim, int tag,
                                   double x, double y, double z,
                                   double lc, void *data)
{
    (void)data;
    if (!g_size_callback_handle) return lc;
    /* feval(handle, dim, tag, x, y, z, lc) */
    mxArray *args[7];
    args[0] = g_size_callback_handle;
    args[1] = mxCreateDoubleScalar((double)dim);
    args[2] = mxCreateDoubleScalar((double)tag);
    args[3] = mxCreateDoubleScalar(x);
    args[4] = mxCreateDoubleScalar(y);
    args[5] = mxCreateDoubleScalar(z);
    args[6] = mxCreateDoubleScalar(lc);
    mxArray *out = NULL;
    int rc = mexCallMATLAB(1, &out, 7, args, "feval");
    double r = lc;
    if (rc == 0 && out && mxIsDouble(out) && mxGetNumberOfElements(out) == 1) {
        r = mxGetScalar(out);
    }
    for (int i = 1; i < 7; ++i) mxDestroyArray(args[i]);
    if (out) mxDestroyArray(out);
    return r;
}

int gmsh_mex_install_size_callback(const mxArray *fn)
{
    if (g_size_callback_handle) {
        mxDestroyArray(g_size_callback_handle);
        g_size_callback_handle = NULL;
    }
    int ierr = 0;
    if (fn && !mxIsEmpty(fn)) {
        g_size_callback_handle = mxDuplicateArray(fn);
        mexMakeArrayPersistent(g_size_callback_handle);
        gmshModelMeshSetSizeCallback(matlab_size_callback, NULL, &ierr);
    } else {
        gmshModelMeshSetSizeCallback(NULL, NULL, &ierr);
    }
    return ierr;
}

void gmsh_mex_clear_callbacks(void)
{
    if (g_size_callback_handle) {
        mxDestroyArray(g_size_callback_handle);
        g_size_callback_handle = NULL;
    }
}
