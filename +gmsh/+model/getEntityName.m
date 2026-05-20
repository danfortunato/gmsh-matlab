function name = getEntityName(dim, tag)
%GETENTITYNAME  gmsh.model.getEntityName
%   Get the name of the entity of dimension `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     name - string

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    name = gmsh.internal.api.call('gmshModelGetEntityName', dim, tag);
end
