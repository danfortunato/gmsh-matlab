function entityType = getType(dim, tag)
%GETTYPE  gmsh.model.getType
%   Get the type of the entity of dimension `dim' and tag `tag'. (This is a
%   deprecated synonym for `getType'.)
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     entityType - string

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    entityType = gmsh.internal.api.call('gmshModelGetType', dim, tag);
end
