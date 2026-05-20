function setColor(dimTags, r, g, b, a, recursive)
%SETCOLOR  gmsh.model.setColor
%   Set the color of the model entities `dimTags' (given as a vector of (dim,
%   tag) pairs) to the RGBA value (`r', `g', `b', `a'), where `r', `g', `b' and
%   `a' should be integers between 0 and 255. Apply the color setting
%   recursively if `recursive' is true.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     r - integer scalar
%     g - integer scalar
%     b - integer scalar
%     a - integer scalar (default 255)
%     recursive - logical scalar (default false)

    arguments
        dimTags
        r (1,1) {mustBeInteger}
        g (1,1) {mustBeInteger}
        b (1,1) {mustBeInteger}
        a (1,1) {mustBeInteger} = 255
        recursive (1,1) logical = false
    end

    gmsh.internal.api.call('gmshModelSetColor', dimTags, r, g, b, a, recursive);
end
