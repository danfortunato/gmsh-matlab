function outDimTags = extrudeBoundaryLayer(dimTags, numElements, heights, recombine, second, viewIndex)
%EXTRUDEBOUNDARYLAYER  gmsh.model.geo.extrudeBoundaryLayer
%   Extrude the entities `dimTags' (given as a vector of (dim, tag) pairs) in
%   the built-in CAD representation along the normals of the mesh, creating
%   discrete boundary layer entities. Return extruded entities in `outDimTags'.
%   The entries in `numElements' give the number of elements in each layer. If
%   the `height' vector is not empty, it provides the (cumulative) height of the
%   different layers. If `recombine' is set, recombine the mesh in the layers. A
%   second boundary layer can be created from the same entities if `second' is
%   set. If `viewIndex' is >= 0, use the corresponding view to either specify
%   the normals (if the view contains a vector field) or scale the normals (if
%   the view is scalar).
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     numElements - vector of integers (default [1])
%     heights - vector of doubles (default [])
%     recombine - logical scalar (default false)
%     second - logical scalar (default false)
%     viewIndex - integer scalar (default -1)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags
        numElements = [1]
        heights = []
        recombine (1,1) logical = false
        second (1,1) logical = false
        viewIndex (1,1) {mustBeInteger} = -1
    end

    outDimTags = gmsh.internal.api.call('gmshModelGeoExtrudeBoundaryLayer', dimTags, numElements, heights, recombine, second, viewIndex);
end
