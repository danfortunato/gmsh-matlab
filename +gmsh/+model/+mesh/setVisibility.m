function setVisibility(elementTags, value)
%SETVISIBILITY  gmsh.model.mesh.setVisibility
%   Set the visibility of the elements of tags `elementTags' to `value'.
%
%   Inputs:
%     elementTags - vector of size_t
%     value - integer scalar

    arguments
        elementTags
        value (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshSetVisibility', elementTags, value);
end
