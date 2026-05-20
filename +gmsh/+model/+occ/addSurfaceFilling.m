function ret = addSurfaceFilling(wireTag, tag, pointTags, degree, numPointsOnCurves, numIter, anisotropic, tol2d, tol3d, tolAng, tolCurv, maxDegree, maxSegments)
%ADDSURFACEFILLING  gmsh.model.occ.addSurfaceFilling
%   Add a surface in the OpenCASCADE CAD representation, filling the curve loop
%   `wireTag'. If `tag' is positive, set the tag explicitly; otherwise a new tag
%   is selected automatically. Return the tag of the surface. If `pointTags' are
%   provided, force the surface to pass through the given points. The other
%   optional arguments are `degree' (the degree of the energy criterion to
%   minimize for computing the deformation of the surface), `numPointsOnCurves'
%   (the average number of points for discretisation of the bounding curves),
%   `numIter' (the maximum number of iterations of the optimization process),
%   `anisotropic' (improve performance when the ratio of the length along the
%   two parametric coordinates of the surface is high), `tol2d' (tolerance to
%   the constraints in the parametric plane of the surface), `tol3d' (the
%   maximum distance allowed between the support surface and the constraints),
%   `tolAng' (the maximum angle allowed between the normal of the surface and
%   the constraints), `tolCurv' (the maximum difference of curvature allowed
%   between the surface and the constraint), `maxDegree' (the highest degree
%   which the polynomial defining the filling surface can have) and,
%   `maxSegments' (the largest number of segments which the filling surface can
%   have).
%
%   Inputs:
%     wireTag - integer scalar
%     tag - integer scalar (default -1)
%     pointTags - vector of integers (default int32([]))
%     degree - integer scalar (default 2)
%     numPointsOnCurves - integer scalar (default 15)
%     numIter - integer scalar (default 2)
%     anisotropic - logical scalar (default false)
%     tol2d - double scalar (default 0.00001)
%     tol3d - double scalar (default 0.0001)
%     tolAng - double scalar (default 0.01)
%     tolCurv - double scalar (default 0.1)
%     maxDegree - integer scalar (default 8)
%     maxSegments - integer scalar (default 9)
%
%   Outputs:
%     ret - integer scalar

    arguments
        wireTag (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        pointTags = int32([])
        degree (1,1) {mustBeInteger} = 2
        numPointsOnCurves (1,1) {mustBeInteger} = 15
        numIter (1,1) {mustBeInteger} = 2
        anisotropic (1,1) logical = false
        tol2d (1,1) double = 0.00001
        tol3d (1,1) double = 0.0001
        tolAng (1,1) double = 0.01
        tolCurv (1,1) double = 0.1
        maxDegree (1,1) {mustBeInteger} = 8
        maxSegments (1,1) {mustBeInteger} = 9
    end

    ret = gmsh.internal.api.call('gmshModelOccAddSurfaceFilling', wireTag, tag, pointTags, degree, numPointsOnCurves, numIter, anisotropic, tol2d, tol3d, tolAng, tolCurv, maxDegree, maxSegments);
end
