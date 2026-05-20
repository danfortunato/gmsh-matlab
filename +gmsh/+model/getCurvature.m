function curvatures = getCurvature(dim, tag, parametricCoord)
%GETCURVATURE  gmsh.model.getCurvature
%   Evaluate the (maximum) curvature of the entity of dimension `dim' and tag
%   `tag' at the parametric coordinates `parametricCoord'. Only valid for `dim'
%   equal to 1 (with `parametricCoord' containing parametric coordinates on the
%   curve) or 2 (with `parametricCoord' containing u, v parametric coordinates
%   on the surface, concatenated: [p1u, p1v, p2u, ...]).
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     parametricCoord - vector of doubles
%
%   Outputs:
%     curvatures - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        parametricCoord
    end

    curvatures = gmsh.internal.api.call('gmshModelGetCurvature', dim, tag, parametricCoord);
end
