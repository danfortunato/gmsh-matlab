function [r, g, b, a] = getColor(name)
%GETCOLOR  gmsh.option.getColor
%   Get the `r', `g', `b', `a' value of a color option. `name' is of the form
%   "Category.Color.Option" or "Category[num].Color.Option". Available
%   categories and options are listed in the "Gmsh options" chapter of the Gmsh
%   reference manual (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-options). For
%   conciseness "Color." can be ommitted in `name'.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     r - integer scalar
%     g - integer scalar
%     b - integer scalar
%     a - integer scalar

    arguments
        name (1,:) char
    end

    [r, g, b, a] = gmsh.internal.api.call('gmshOptionGetColor', name);
end
