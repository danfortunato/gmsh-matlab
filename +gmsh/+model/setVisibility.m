function setVisibility(dimTags, value, recursive)
%SETVISIBILITY  gmsh.model.setVisibility
%   Set the visibility of the model entities `dimTags' (given as a vector of
%   (dim, tag) pairs) to `value'. Apply the visibility setting recursively if
%   `recursive' is true.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     value - integer scalar
%     recursive - logical scalar (default false)

    arguments
        dimTags
        value (1,1) {mustBeInteger}
        recursive (1,1) logical = false
    end

    gmsh.internal.api.call('gmshModelSetVisibility', dimTags, value, recursive);
end
