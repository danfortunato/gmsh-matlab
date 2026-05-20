function ret = addBSpline(pointTags, tag, degree, weights, knots, multiplicities)
%ADDBSPLINE  gmsh.model.occ.addBSpline
%   Add a b-spline curve of degree `degree' in the OpenCASCADE CAD
%   representation, with `pointTags' control points. If `weights', `knots' or
%   `multiplicities' are not provided, default parameters are computed
%   automatically. If `tag' is positive, set the tag explicitly; otherwise a new
%   tag is selected automatically. Create a periodic curve if the first and last
%   points are the same. Return the tag of the b-spline curve.
%
%   Inputs:
%     pointTags - vector of integers
%     tag - integer scalar (default -1)
%     degree - integer scalar (default 3)
%     weights - vector of doubles (default [])
%     knots - vector of doubles (default [])
%     multiplicities - vector of integers (default int32([]))
%
%   Outputs:
%     ret - integer scalar

    arguments
        pointTags
        tag (1,1) {mustBeInteger} = -1
        degree (1,1) {mustBeInteger} = 3
        weights = []
        knots = []
        multiplicities = int32([])
    end

    ret = gmsh.internal.api.call('gmshModelOccAddBSpline', pointTags, tag, degree, weights, knots, multiplicities);
end
