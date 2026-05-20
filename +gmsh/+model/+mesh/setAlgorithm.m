function setAlgorithm(dim, tag, val)
%SETALGORITHM  gmsh.model.mesh.setAlgorithm
%   Set the meshing algorithm on the model entity of dimension `dim' and tag
%   `tag'. Supported values are those of the `Mesh.Algorithm' option, as listed
%   in the Gmsh reference manual. Currently only supported for `dim' == 2.
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

    gmsh.internal.api.call('gmshModelMeshSetAlgorithm', dim, tag, val);
end
