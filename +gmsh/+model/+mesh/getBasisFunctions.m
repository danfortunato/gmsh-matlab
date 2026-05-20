function [numComponents, basisFunctions, numOrientations] = getBasisFunctions(elementType, localCoord, functionSpaceType, wantedOrientations)
%GETBASISFUNCTIONS  gmsh.model.mesh.getBasisFunctions
%   Get the basis functions of the element of type `elementType' at the
%   evaluation points `localCoord' (given as concatenated u, v, w coordinates in
%   the reference element [g1u, g1v, g1w, ..., gGu, gGv, gGw]), for the function
%   space `functionSpaceType'. Currently supported function spaces include
%   "Lagrange" and "GradLagrange" for isoparametric Lagrange basis functions and
%   their gradient in the u, v, w coordinates of the reference element;
%   "LagrangeN" and "GradLagrangeN", with N = 1, 2, ..., for N-th order Lagrange
%   basis functions; "H1LegendreN" and "GradH1LegendreN", with N = 1, 2, ...,
%   for N-th order hierarchical H1 Legendre functions; "HcurlLegendreN" and
%   "CurlHcurlLegendreN", with N = 1, 2, ..., for N-th order curl-conforming
%   basis functions. `numComponents' returns the number C of components of a
%   basis function (e.g. 1 for scalar functions and 3 for vector functions).
%   `basisFunctions' returns the value of the N basis functions at the
%   evaluation points, i.e. [g1f1, g1f2, ..., g1fN, g2f1, ...] when C == 1 or
%   [g1f1u, g1f1v, g1f1w, g1f2u, ..., g1fNw, g2f1u, ...] when C == 3. For basis
%   functions that depend on the orientation of the elements, all values for the
%   first orientation are returned first, followed by values for the second,
%   etc. `numOrientations' returns the overall number of orientations. If the
%   `wantedOrientations' vector is not empty, only return the values for the
%   desired orientation indices.
%
%   Inputs:
%     elementType - integer scalar
%     localCoord - vector of doubles
%     functionSpaceType - string
%     wantedOrientations - vector of integers (default int32([]))
%
%   Outputs:
%     numComponents - integer scalar
%     basisFunctions - row vector of doubles
%     numOrientations - integer scalar

    arguments
        elementType (1,1) {mustBeInteger}
        localCoord
        functionSpaceType (1,:) char
        wantedOrientations = int32([])
    end

    [numComponents, basisFunctions, numOrientations] = gmsh.internal.api.call('gmshModelMeshGetBasisFunctions', elementType, localCoord, functionSpaceType, wantedOrientations);
end
