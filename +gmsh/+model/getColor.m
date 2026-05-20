function [r, g, b, a] = getColor(dim, tag)
%GETCOLOR  gmsh.model.getColor
%   Get the color of the model entity of dimension `dim' and tag `tag'. If no
%   color is specified for the entity, return fully transparent blue, i.e. (0,
%   0, 255, 0).
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     r - integer scalar
%     g - integer scalar
%     b - integer scalar
%     a - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [r, g, b, a] = gmsh.internal.api.call('gmshModelGetColor', dim, tag);
end
