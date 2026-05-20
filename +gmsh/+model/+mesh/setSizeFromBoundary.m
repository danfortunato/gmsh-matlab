function setSizeFromBoundary(dim, tag, val)
%SETSIZEFROMBOUNDARY  gmsh.model.mesh.setSizeFromBoundary
%   Force the mesh size to be extended from the boundary, or not, for the model
%   entity of dimension `dim' and tag `tag'. Currently only supported for `dim'
%   == 2.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     val - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        val (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshSetSizeFromBoundary', dim, tag, val);
end
