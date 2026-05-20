function reverseElements(elementTags)
%REVERSEELEMENTS  gmsh.model.mesh.reverseElements
%   Reverse the orientation of the elements with tags `elementTags'.
%
%   Inputs:
%     elementTags - vector of size_t

    arguments
        elementTags
    end

    gmsh.internal.api.call('gmshModelMeshReverseElements', elementTags);
end
