function [min, max] = getParametrizationBounds(dim, tag)
%GETPARAMETRIZATIONBOUNDS  gmsh.model.getParametrizationBounds
%   Get the `min' and `max' bounds of the parametric coordinates for the entity
%   of dimension `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     min - row vector of doubles
%     max - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [min, max] = gmsh.internal.api.call('gmshModelGetParametrizationBounds', dim, tag);
end
