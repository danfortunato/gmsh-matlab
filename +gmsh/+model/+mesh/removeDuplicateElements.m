function removeDuplicateElements(dimTags)
%REMOVEDUPLICATEELEMENTS  gmsh.model.mesh.removeDuplicateElements
%   Remove duplicate elements (defined by the same nodes, in the same entity) in
%   the mesh of the entities `dimTags', given as a vector of (dim, tag) pairs.
%   If `dimTags' is empty, consider the whole mesh.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshRemoveDuplicateElements', dimTags);
end
