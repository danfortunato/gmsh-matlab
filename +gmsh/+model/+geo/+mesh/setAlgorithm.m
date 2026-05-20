function setAlgorithm(dim, tag, val)
%SETALGORITHM  gmsh.model.geo.mesh.setAlgorithm
%   Set the meshing algorithm on the entity of dimension `dim' and tag `tag' in
%   the built-in CAD kernel representation. Currently only supported for `dim'
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

    gmsh.internal.api.call('gmshModelGeoMeshSetAlgorithm', dim, tag, val);
end
