function setRecombine(dim, tag, angle)
%SETRECOMBINE  gmsh.model.geo.mesh.setRecombine
%   Set a recombination meshing constraint on the entity of dimension `dim' and
%   tag `tag' in the built-in CAD kernel representation. Currently only entities
%   of dimension 2 (to recombine triangles into quadrangles) are supported;
%   `angle' specifies the threshold angle for the simple recombination
%   algorithm.
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

    gmsh.internal.api.call('gmshModelGeoMeshSetRecombine', dim, tag, angle);
end
