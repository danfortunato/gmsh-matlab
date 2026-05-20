function setSmoothing(dim, tag, val)
%SETSMOOTHING  gmsh.model.geo.mesh.setSmoothing
%   Set a smoothing meshing constraint on the entity of dimension `dim' and tag
%   `tag' in the built-in CAD kernel representation. `val' iterations of a
%   Laplace smoother are applied.
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

    gmsh.internal.api.call('gmshModelGeoMeshSetSmoothing', dim, tag, val);
end
