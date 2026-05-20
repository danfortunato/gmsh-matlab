function setTransfiniteCurve(tag, nPoints, meshType, coef)
%SETTRANSFINITECURVE  gmsh.model.geo.mesh.setTransfiniteCurve
%   Set a transfinite meshing constraint on the curve `tag' in the built-in CAD
%   kernel representation, with `numNodes' nodes distributed according to
%   `meshType' and `coef'. Currently supported types are "Progression"
%   (geometrical progression with power `coef') and "Bump" (refinement toward
%   both extremities of the curve).
%
%   Inputs:
%     tag - integer scalar
%     nPoints - integer scalar
%     meshType - string (default "Progression")
%     coef - double scalar (default 1.)

    arguments
        tag (1,1) {mustBeInteger}
        nPoints (1,1) {mustBeInteger}
        meshType (1,:) char = "Progression"
        coef (1,1) double = 1.
    end

    gmsh.internal.api.call('gmshModelGeoMeshSetTransfiniteCurve', tag, nPoints, meshType, coef);
end
