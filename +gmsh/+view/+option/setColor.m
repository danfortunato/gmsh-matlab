function setColor(tag, name, r, g, b, a)
%SETCOLOR  gmsh.view.option.setColor
%   Set the color option `name' to the RGBA value (`r', `g', `b', `a') for the
%   view with tag `tag', where where `r', `g', `b' and `a' should be integers
%   between 0 and 255.
%
%   Inputs:
%     tag - integer scalar
%     name - string
%     r - integer scalar
%     g - integer scalar
%     b - integer scalar
%     a - integer scalar (default 255)

    arguments
        tag (1,1) {mustBeInteger}
        name (1,:) char
        r (1,1) {mustBeInteger}
        g (1,1) {mustBeInteger}
        b (1,1) {mustBeInteger}
        a (1,1) {mustBeInteger} = 255
    end

    gmsh.internal.api.call('gmshViewOptionSetColor', tag, name, r, g, b, a);
end
