function ret = addCompoundBSpline(curveTags, numIntervals, tag)
%ADDCOMPOUNDBSPLINE  gmsh.model.geo.addCompoundBSpline
%   Add a b-spline curve in the built-in CAD representation, with control points
%   sampling the curves in `curveTags'. The density of sampling points on each
%   curve is governed by `numIntervals'. If `tag' is positive, set the tag
%   explicitly; otherwise a new tag is selected automatically. Return the tag of
%   the b-spline.
%
%   Inputs:
%     curveTags - vector of integers
%     numIntervals - integer scalar (default 20)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        curveTags
        numIntervals (1,1) {mustBeInteger} = 20
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddCompoundBSpline', curveTags, numIntervals, tag);
end
