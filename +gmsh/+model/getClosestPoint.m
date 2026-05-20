function [closestCoord, parametricCoord] = getClosestPoint(dim, tag, coord)
%GETCLOSESTPOINT  gmsh.model.getClosestPoint
%   Get the points `closestCoord' on the entity of dimension `dim' (1 or 2) and
%   tag `tag' to the points `coord', by orthogonal projection. `coord' and
%   `closestCoord' are given as x, y, z coordinates, concatenated: [p1x, p1y,
%   p1z, p2x, ...]. `parametricCoord' returns the parametric coordinates t on
%   the curve (if `dim' == 1) or u and v coordinates concatenated on the surface
%   (if `dim' = 2), i.e. [p1t, p2t, ...] or [p1u, p1v, p2u, ...]. The closest
%   points can lie outside the (trimmed) entities: use `isInside()' to check.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     coord - vector of doubles
%
%   Outputs:
%     closestCoord - row vector of doubles
%     parametricCoord - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        coord
    end

    [closestCoord, parametricCoord] = gmsh.internal.api.call('gmshModelGetClosestPoint', dim, tag, coord);
end
