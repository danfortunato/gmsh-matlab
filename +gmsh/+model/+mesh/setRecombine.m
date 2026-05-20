function setRecombine(dim, tag, angle)
%SETRECOMBINE  gmsh.model.mesh.setRecombine
%   Set a recombination meshing constraint on the model entity of dimension
%   `dim' and tag `tag'. Currently only entities of dimension 2 (to recombine
%   triangles into quadrangles) are supported; `angle' specifies the threshold
%   angle for the simple recombination algorithm..
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     angle - double scalar (default 45.)

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        angle (1,1) double = 45.
    end

    gmsh.internal.api.call('gmshModelMeshSetRecombine', dim, tag, angle);
end
