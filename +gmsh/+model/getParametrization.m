function parametricCoord = getParametrization(dim, tag, coord)
%GETPARAMETRIZATION  gmsh.model.getParametrization
%   Get the parametric coordinates `parametricCoord' for the points `coord' on
%   the entity of dimension `dim' and tag `tag'. `coord' are given as x, y, z
%   coordinates, concatenated: [p1x, p1y, p1z, p2x, ...]. `parametricCoord'
%   returns the parametric coordinates t on the curve (if `dim' = 1) or u and v
%   coordinates concatenated on the surface (if `dim' == 2), i.e. [p1t, p2t,
%   ...] or [p1u, p1v, p2u, ...].
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     coord - vector of doubles
%
%   Outputs:
%     parametricCoord - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        coord
    end

    parametricCoord = gmsh.internal.api.call('gmshModelGetParametrization', dim, tag, coord);
end
