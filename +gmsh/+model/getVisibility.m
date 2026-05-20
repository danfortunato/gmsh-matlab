function value = getVisibility(dim, tag)
%GETVISIBILITY  gmsh.model.getVisibility
%   Get the visibility of the model entity of dimension `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     value - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    value = gmsh.internal.api.call('gmshModelGetVisibility', dim, tag);
end
