function [localCoord, weights] = getIntegrationPoints(elementType, integrationType)
%GETINTEGRATIONPOINTS  gmsh.model.mesh.getIntegrationPoints
%   Get the numerical quadrature information for the given element type
%   `elementType' and integration rule `integrationType', where
%   `integrationType' concatenates the integration rule family name with the
%   desired order (e.g. "Gauss4" for a quadrature suited for integrating 4th
%   order polynomials). The "CompositeGauss" family uses tensor-product rules
%   based the 1D Gauss-Legendre rule; the "Gauss" family uses an economic scheme
%   when available (i.e. with a minimal number of points), and falls back to
%   "CompositeGauss" otherwise. Note that integration points for the "Gauss"
%   family can fall outside of the reference element for high-order rules.
%   `localCoord' contains the u, v, w coordinates of the G integration points in
%   the reference element: [g1u, g1v, g1w, ..., gGu, gGv, gGw]. `weights'
%   contains the associated weights: [g1q, ..., gGq].
%
%   Inputs:
%     elementType - integer scalar
%     integrationType - string
%
%   Outputs:
%     localCoord - row vector of doubles
%     weights - row vector of doubles

    arguments
        elementType (1,1) {mustBeInteger}
        integrationType (1,:) char
    end

    [localCoord, weights] = gmsh.internal.api.call('gmshModelMeshGetIntegrationPoints', elementType, integrationType);
end
