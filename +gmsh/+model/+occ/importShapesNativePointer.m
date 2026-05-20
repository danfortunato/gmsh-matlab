function outDimTags = importShapesNativePointer(shape, highestDimOnly)
%IMPORTSHAPESNATIVEPOINTER  gmsh.model.occ.importShapesNativePointer
%   Import an OpenCASCADE `shape' by providing a pointer to a native OpenCASCADE
%   `TopoDS_Shape' object (passed as a pointer to void). The imported entities
%   are returned in `outDimTags' as a vector of (dim, tag) pairs. If the
%   optional argument `highestDimOnly' is set, only import the highest
%   dimensional entities in `shape'. In Python, this function can be used for
%   integration with PythonOCC, in which the SwigPyObject pointer of
%   `TopoDS_Shape' must be passed as an int to `shape', i.e., `shape =
%   int(pythonocc_shape.this)'. Warning: this function is unsafe, as providing
%   an invalid pointer will lead to undefined behavior.
%
%   Inputs:
%     shape - void* (uint64 address)
%     highestDimOnly - logical scalar (default true)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        shape
        highestDimOnly (1,1) logical = true
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccImportShapesNativePointer', shape, highestDimOnly);
end
