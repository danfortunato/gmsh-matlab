function [r, g, b, a] = getColor(tag, name)
%GETCOLOR  gmsh.view.option.getColor
%   Get the `r', `g', `b', `a' value of the color option `name' for the view
%   with tag `tag'.
%
%   Inputs:
%     tag - integer scalar
%     name - string
%
%   Outputs:
%     r - integer scalar
%     g - integer scalar
%     b - integer scalar
%     a - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
        name (1,:) char
    end

    [r, g, b, a] = gmsh.internal.api.call('gmshViewOptionGetColor', tag, name);
end
