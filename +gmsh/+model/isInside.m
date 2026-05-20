function ret = isInside(dim, tag, coord, parametric)
%ISINSIDE  gmsh.model.isInside
%   Check if the coordinates (or the parametric coordinates if `parametric' is
%   set) provided in `coord' correspond to points inside the entity of dimension
%   `dim' and tag `tag', and return the number of points inside. This feature is
%   only available for a subset of entities, depending on the underlying
%   geometrical representation.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     coord - vector of doubles
%     parametric - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        coord
        parametric (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelIsInside', dim, tag, coord, parametric);
end
