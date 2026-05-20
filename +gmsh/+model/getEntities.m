function dimTags = getEntities(dim)
%GETENTITIES  gmsh.model.getEntities
%   Get all the entities in the current model. A model entity is represented by
%   two integers: its dimension (dim == 0, 1, 2 or 3) and its tag (its unique,
%   strictly positive identifier). If `dim' is >= 0, return only the entities of
%   the specified dimension (e.g. points if `dim' == 0). The entities are
%   returned as a vector of (dim, tag) pairs.
%
%   Inputs:
%     dim - integer scalar (default -1)
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dim (1,1) {mustBeInteger} = -1
    end

    dimTags = gmsh.internal.api.call('gmshModelGetEntities', dim);
end
