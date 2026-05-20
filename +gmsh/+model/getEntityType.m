function entityType = getEntityType(dim, tag)
%GETENTITYTYPE  gmsh.model.getEntityType
%   Get the type of the entity of dimension `dim' and tag `tag'.
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

    entityType = gmsh.internal.api.call('gmshModelGetEntityType', dim, tag);
end
