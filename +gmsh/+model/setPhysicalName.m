function setPhysicalName(dim, tag, name)
%SETPHYSICALNAME  gmsh.model.setPhysicalName
%   Set the name of the physical group of dimension `dim' and tag `tag'.
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

    gmsh.internal.api.call('gmshModelSetPhysicalName', dim, tag, name);
end
