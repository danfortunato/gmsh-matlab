function setColor(name, r, g, b, a)
%SETCOLOR  gmsh.option.setColor
%   Set a color option to the RGBA value (`r', `g', `b', `a'), where where `r',
%   `g', `b' and `a' should be integers between 0 and 255. `name' is of the form
%   "Category.Color.Option" or "Category[num].Color.Option". Available
%   categories and options are listed in the "Gmsh options" chapter of the Gmsh
%   reference manual (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-options). For
%   conciseness "Color." can be ommitted in `name'.
%
%   Inputs:
%     name - string
%     r - integer scalar
%     g - integer scalar
%     b - integer scalar
%     a - integer scalar (default 255)

    arguments
        name (1,:) char
        r (1,1) {mustBeInteger}
        g (1,1) {mustBeInteger}
        b (1,1) {mustBeInteger}
        a (1,1) {mustBeInteger} = 255
    end

    gmsh.internal.api.call('gmshOptionSetColor', name, r, g, b, a);
end
