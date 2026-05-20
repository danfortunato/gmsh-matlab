function setTag(dim, tag, newTag)
%SETTAG  gmsh.model.setTag
%   Set the tag of the entity of dimension `dim' and tag `tag' to the new value
%   `newTag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     newTag - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        newTag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelSetTag', dim, tag, newTag);
end
