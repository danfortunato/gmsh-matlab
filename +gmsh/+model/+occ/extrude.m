function outDimTags = extrude(dimTags, dx, dy, dz, numElements, heights, recombine)
%EXTRUDE  gmsh.model.occ.extrude
%   Extrude the entities `dimTags' (given as a vector of (dim, tag) pairs) in
%   the OpenCASCADE CAD representation, using a translation along (`dx', `dy',
%   `dz'). Return extruded entities in `outDimTags'. If the `numElements' vector
%   is not empty, also extrude the mesh: the entries in `numElements' give the
%   number of elements in each layer. If the `height' vector is not empty, it
%   provides the (cumulative) height of the different layers, normalized to 1.
%   If `recombine' is set, recombine the mesh in the layers.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     dx - double scalar
%     dy - double scalar
%     dz - double scalar
%     numElements - vector of integers (default int32([]))
%     heights - vector of doubles (default [])
%     recombine - logical scalar (default false)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags
        dx (1,1) double
        dy (1,1) double
        dz (1,1) double
        numElements = int32([])
        heights = []
        recombine (1,1) logical = false
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccExtrude', dimTags, dx, dy, dz, numElements, heights, recombine);
end
