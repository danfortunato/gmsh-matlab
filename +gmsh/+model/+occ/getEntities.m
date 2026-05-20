function dimTags = getEntities(dim)
%GETENTITIES  gmsh.model.occ.getEntities
%   Get all the OpenCASCADE entities. If `dim' is >= 0, return only the entities
%   of the specified dimension (e.g. points if `dim' == 0). The entities are
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

    dimTags = gmsh.internal.api.call('gmshModelOccGetEntities', dim);
end
