function setCompound(dim, tags)
%SETCOMPOUND  gmsh.model.mesh.setCompound
%   Set a compound meshing constraint on the model entities of dimension `dim'
%   and tags `tags'. During meshing, compound entities are treated as a single
%   discrete entity, which is automatically reparametrized.
%
%   Inputs:
%     dim - integer scalar
%     tags - vector of integers

    arguments
        dim (1,1) {mustBeInteger}
        tags
    end

    gmsh.internal.api.call('gmshModelMeshSetCompound', dim, tags);
end
