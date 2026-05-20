function [upward, downward] = getAdjacencies(dim, tag)
%GETADJACENCIES  gmsh.model.getAdjacencies
%   Get the upward and downward adjacencies of the model entity of dimension
%   `dim' and tag `tag'. The `upward' vector returns the tags of adjacent
%   entities of dimension `dim' + 1; the `downward' vector returns the tags of
%   adjacent entities of dimension `dim' - 1.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     upward - row vector of int32
%     downward - row vector of int32

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [upward, downward] = gmsh.internal.api.call('gmshModelGetAdjacencies', dim, tag);
end
