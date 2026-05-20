function name = getPhysicalName(dim, tag)
%GETPHYSICALNAME  gmsh.model.getPhysicalName
%   Get the name of the physical group of dimension `dim' and tag `tag'.
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

    name = gmsh.internal.api.call('gmshModelGetPhysicalName', dim, tag);
end
