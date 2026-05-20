function ret = addPhysicalGroup(dim, tags, tag, name)
%ADDPHYSICALGROUP  gmsh.model.geo.addPhysicalGroup
%   Add a physical group of dimension `dim', grouping the entities with tags
%   `tags' in the built-in CAD representation. Return the tag of the physical
%   group, equal to `tag' if `tag' is positive, or a new tag if `tag' < 0. Set
%   the name of the physical group if `name' is not empty.
%
%   Inputs:
%     dim - integer scalar
%     tags - vector of integers
%     tag - integer scalar (default -1)
%     name - string (default '')
%
%   Outputs:
%     ret - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tags
        tag (1,1) {mustBeInteger} = -1
        name (1,:) char = ''
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddPhysicalGroup', dim, tags, tag, name);
end
