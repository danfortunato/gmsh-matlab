function [ret, dimTags] = selectEntities(dim)
%SELECTENTITIES  gmsh.fltk.selectEntities
%   Select entities in the user interface. Return the selected entities as a
%   vector of (dim, tag) pairs. If `dim' is >= 0, return only the entities of
%   the specified dimension (e.g. points if `dim' == 0).
%
%   Inputs:
%     dim - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar
%     dimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dim (1,1) {mustBeInteger} = -1
    end

    [ret, dimTags] = gmsh.internal.api.call('gmshFltkSelectEntities', dim);
end
