function renumberElements(oldTags, newTags)
%RENUMBERELEMENTS  gmsh.model.mesh.renumberElements
%   Renumber the element tags in a continuous sequence. If no explicit
%   renumbering is provided through the `oldTags' and `newTags' vectors,
%   renumber the elements in a continuous sequence, taking into account the
%   subset of elements to be saved later on if the option "Mesh.SaveAll" is not
%   set.
%
%   Inputs:
%     oldTags - vector of size_t (default uint64([]))
%     newTags - vector of size_t (default uint64([]))

    arguments
        oldTags = uint64([])
        newTags = uint64([])
    end

    gmsh.internal.api.call('gmshModelMeshRenumberElements', oldTags, newTags);
end
