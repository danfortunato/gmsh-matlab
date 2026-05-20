function values = getVisibility(elementTags)
%GETVISIBILITY  gmsh.model.mesh.getVisibility
%   Get the visibility of the elements of tags `elementTags'.
%
%   Inputs:
%     elementTags - vector of size_t
%
%   Outputs:
%     values - row vector of int32

    arguments
        elementTags
    end

    values = gmsh.internal.api.call('gmshModelMeshGetVisibility', elementTags);
end
