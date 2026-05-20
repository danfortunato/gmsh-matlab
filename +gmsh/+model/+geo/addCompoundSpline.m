function ret = addCompoundSpline(curveTags, numIntervals, tag)
%ADDCOMPOUNDSPLINE  gmsh.model.geo.addCompoundSpline
%   Add a spline (Catmull-Rom) curve in the built-in CAD representation, going
%   through points sampling the curves in `curveTags'. The density of sampling
%   points on each curve is governed by `numIntervals'. If `tag' is positive,
%   set the tag explicitly; otherwise a new tag is selected automatically.
%   Return the tag of the spline.
%
%   Inputs:
%     curveTags - vector of integers
%     numIntervals - integer scalar (default 5)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        curveTags
        numIntervals (1,1) {mustBeInteger} = 5
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddCompoundSpline', curveTags, numIntervals, tag);
end
