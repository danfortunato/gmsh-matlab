function [curvatureMax, curvatureMin, directionMax, directionMin] = getPrincipalCurvatures(tag, parametricCoord)
%GETPRINCIPALCURVATURES  gmsh.model.getPrincipalCurvatures
%   Evaluate the principal curvatures of the surface with tag `tag' at the
%   parametric coordinates `parametricCoord', as well as their respective
%   directions. `parametricCoord' are given by pair of u and v coordinates,
%   concatenated: [p1u, p1v, p2u, ...].
%
%   Inputs:
%     tag - integer scalar
%     parametricCoord - vector of doubles
%
%   Outputs:
%     curvatureMax - row vector of doubles
%     curvatureMin - row vector of doubles
%     directionMax - row vector of doubles
%     directionMin - row vector of doubles

    arguments
        tag (1,1) {mustBeInteger}
        parametricCoord
    end

    [curvatureMax, curvatureMin, directionMax, directionMin] = gmsh.internal.api.call('gmshModelGetPrincipalCurvatures', tag, parametricCoord);
end
