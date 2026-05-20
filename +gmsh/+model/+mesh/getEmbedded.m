function dimTags = getEmbedded(dim, tag)
%GETEMBEDDED  gmsh.model.mesh.getEmbedded
%   Get the entities (if any) embedded in the model entity of dimension `dim'
%   and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    dimTags = gmsh.internal.api.call('gmshModelMeshGetEmbedded', dim, tag);
end
