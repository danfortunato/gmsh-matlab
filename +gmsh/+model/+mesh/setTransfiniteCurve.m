function setTransfiniteCurve(tag, numNodes, meshType, coef)
%SETTRANSFINITECURVE  gmsh.model.mesh.setTransfiniteCurve
%   Set a transfinite meshing constraint on the curve `tag', with `numNodes'
%   nodes distributed according to `meshType' and `coef'. Currently supported
%   types are "Progression" (geometrical progression with power `coef'), "Bump"
%   (refinement toward both extremities of the curve) and "Beta" (beta law).
%
%   Inputs:
%     tag - integer scalar
%     numNodes - integer scalar
%     meshType - string (default "Progression")
%     coef - double scalar (default 1.)

    arguments
        tag (1,1) {mustBeInteger}
        numNodes (1,1) {mustBeInteger}
        meshType (1,:) char = "Progression"
        coef (1,1) double = 1.
    end

    gmsh.internal.api.call('gmshModelMeshSetTransfiniteCurve', tag, numNodes, meshType, coef);
end
