function removeEmbedded(dimTags, dim)
%REMOVEEMBEDDED  gmsh.model.mesh.removeEmbedded
%   Remove embedded entities from the model entities `dimTags', given as a
%   vector of (dim, tag) pairs. if `dim' is >= 0, only remove embedded entities
%   of the given dimension (e.g. embedded points if `dim' == 0).
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     dim - integer scalar (default -1)

    arguments
        dimTags
        dim (1,1) {mustBeInteger} = -1
    end

    gmsh.internal.api.call('gmshModelMeshRemoveEmbedded', dimTags, dim);
end
