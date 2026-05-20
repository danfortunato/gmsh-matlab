function setSizeAtParametricPoints(dim, tag, parametricCoord, sizes)
%SETSIZEATPARAMETRICPOINTS  gmsh.model.mesh.setSizeAtParametricPoints
%   Set mesh size constraints at the given parametric points `parametricCoord'
%   on the model entity of dimension `dim' and tag `tag'. Currently only
%   entities of dimension 1 (lines) are handled.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     parametricCoord - vector of doubles
%     sizes - vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        parametricCoord
        sizes
    end

    gmsh.internal.api.call('gmshModelMeshSetSizeAtParametricPoints', dim, tag, parametricCoord, sizes);
end
