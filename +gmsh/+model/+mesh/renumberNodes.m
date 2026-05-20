function renumberNodes(oldTags, newTags)
%RENUMBERNODES  gmsh.model.mesh.renumberNodes
%   Renumber the node tags. If no explicit renumbering is provided through the
%   `oldTags' and `newTags' vectors, renumber the nodes in a continuous
%   sequence, taking into account the subset of elements to be saved later on if
%   the option "Mesh.SaveAll" is not set.
%
%   Inputs:
%     oldTags - vector of size_t (default uint64([]))
%     newTags - vector of size_t (default uint64([]))

    arguments
        oldTags = uint64([])
        newTags = uint64([])
    end

    gmsh.internal.api.call('gmshModelMeshRenumberNodes', oldTags, newTags);
end
