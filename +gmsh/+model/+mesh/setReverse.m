function setReverse(dim, tag, val)
%SETREVERSE  gmsh.model.mesh.setReverse
%   Set a reverse meshing constraint on the model entity of dimension `dim' and
%   tag `tag'. If `val' is true, the mesh orientation will be reversed with
%   respect to the natural mesh orientation (i.e. the orientation consistent
%   with the orientation of the geometry). If `val' is false, the mesh is left
%   as-is.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     val - logical scalar (default true)

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        val (1,1) logical = true
    end

    gmsh.internal.api.call('gmshModelMeshSetReverse', dim, tag, val);
end
