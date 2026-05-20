function setEntityName(dim, tag, name)
%SETENTITYNAME  gmsh.model.setEntityName
%   Set the name of the entity of dimension `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     name - string

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        name (1,:) char
    end

    gmsh.internal.api.call('gmshModelSetEntityName', dim, tag, name);
end
