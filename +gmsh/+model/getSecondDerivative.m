function derivatives = getSecondDerivative(dim, tag, parametricCoord)
%GETSECONDDERIVATIVE  gmsh.model.getSecondDerivative
%   Evaluate the second derivative of the parametrization of the entity of
%   dimension `dim' and tag `tag' at the parametric coordinates
%   `parametricCoord'. Only valid for `dim' equal to 1 (with `parametricCoord'
%   containing parametric coordinates on the curve) or 2 (with `parametricCoord'
%   containing u, v parametric coordinates on the surface, concatenated: [p1u,
%   p1v, p2u, ...]). For `dim' equal to 1 return the x, y, z components of the
%   second derivative with respect to u [d1uux, d1uuy, d1uuz, d2uux, ...]; for
%   `dim' equal to 2 return the x, y, z components of the second derivative with
%   respect to u and v, and the mixed derivative with respect to u and v:
%   [d1uux, d1uuy, d1uuz, d1vvx, d1vvy, d1vvz, d1uvx, d1uvy, d1uvz, d2uux, ...].
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     parametricCoord - vector of doubles
%
%   Outputs:
%     derivatives - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        parametricCoord
    end

    derivatives = gmsh.internal.api.call('gmshModelGetSecondDerivative', dim, tag, parametricCoord);
end
