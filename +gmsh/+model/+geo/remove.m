function remove(dimTags, recursive)
%REMOVE  gmsh.model.geo.remove
%   Remove the entities `dimTags' (given as a vector of (dim, tag) pairs) in the
%   built-in CAD representation, provided that they are not on the boundary of
%   higher-dimensional entities. If `recursive' is true, remove all the entities
%   on their boundaries, down to dimension 0.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     recursive - logical scalar (default false)

    arguments
        dimTags
        recursive (1,1) logical = false
    end

    gmsh.internal.api.call('gmshModelGeoRemove', dimTags, recursive);
end
