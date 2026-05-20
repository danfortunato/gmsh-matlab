function coord = getValue(dim, tag, parametricCoord)
%GETVALUE  gmsh.model.getValue
%   Evaluate the parametrization of the entity of dimension `dim' and tag `tag'
%   at the parametric coordinates `parametricCoord'. Only valid for `dim' equal
%   to 0 (with empty `parametricCoord'), 1 (with `parametricCoord' containing
%   parametric coordinates on the curve) or 2 (with `parametricCoord' containing
%   u, v parametric coordinates on the surface, concatenated: [p1u, p1v, p2u,
%   ...]). Return x, y, z coordinates in `coord', concatenated: [p1x, p1y, p1z,
%   p2x, ...].
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     parametricCoord - vector of doubles
%
%   Outputs:
%     coord - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        parametricCoord
    end

    coord = gmsh.internal.api.call('gmshModelGetValue', dim, tag, parametricCoord);
end
