function remove(dimTags, recursive)
%REMOVE  gmsh.model.occ.remove
%   Remove the entities `dimTags' (given as a vector of (dim, tag) pairs) in the
%   OpenCASCADE CAD representation, provided that they are not on the boundary
%   of higher-dimensional entities. If `recursive' is true, remove all the
%   entities on their boundaries, down to dimension 0.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     recursive - logical scalar (default false)

    arguments
        dimTags
        recursive (1,1) logical = false
    end

    gmsh.internal.api.call('gmshModelOccRemove', dimTags, recursive);
end
