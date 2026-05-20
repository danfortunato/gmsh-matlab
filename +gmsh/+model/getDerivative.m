function derivatives = getDerivative(dim, tag, parametricCoord)
%GETDERIVATIVE  gmsh.model.getDerivative
%   Evaluate the derivative of the parametrization of the entity of dimension
%   `dim' and tag `tag' at the parametric coordinates `parametricCoord'. Only
%   valid for `dim' equal to 1 (with `parametricCoord' containing parametric
%   coordinates on the curve) or 2 (with `parametricCoord' containing u, v
%   parametric coordinates on the surface, concatenated: [p1u, p1v, p2u, ...]).
%   For `dim' equal to 1 return the x, y, z components of the derivative with
%   respect to u [d1ux, d1uy, d1uz, d2ux, ...]; for `dim' equal to 2 return the
%   x, y, z components of the derivative with respect to u and v: [d1ux, d1uy,
%   d1uz, d1vx, d1vy, d1vz, d2ux, ...].
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

    derivatives = gmsh.internal.api.call('gmshModelGetDerivative', dim, tag, parametricCoord);
end
