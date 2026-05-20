function removeDuplicateNodes(dimTags)
%REMOVEDUPLICATENODES  gmsh.model.mesh.removeDuplicateNodes
%   Remove duplicate nodes in the mesh of the entities `dimTags', given as a
%   vector of (dim, tag) pairs. If `dimTags' is empty, consider the whole mesh.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshRemoveDuplicateNodes', dimTags);
end
