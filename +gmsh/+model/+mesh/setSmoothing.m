function setSmoothing(dim, tag, val)
%SETSMOOTHING  gmsh.model.mesh.setSmoothing
%   Set a smoothing meshing constraint on the model entity of dimension `dim'
%   and tag `tag'. `val' iterations of a Laplace smoother are applied.
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

    gmsh.internal.api.call('gmshModelMeshSetSmoothing', dim, tag, val);
end
