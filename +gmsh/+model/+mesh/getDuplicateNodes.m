function tags = getDuplicateNodes(dimTags)
%GETDUPLICATENODES  gmsh.model.mesh.getDuplicateNodes
%   Get the `tags' of any duplicate nodes in the mesh of the entities `dimTags',
%   given as a vector of (dim, tag) pairs. If `dimTags' is empty, consider the
%   whole mesh.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))
%
%   Outputs:
%     tags - row vector of uint64

    arguments
        dimTags = zeros(0,2)
    end

    tags = gmsh.internal.api.call('gmshModelMeshGetDuplicateNodes', dimTags);
end
