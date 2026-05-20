function ret = addBSpline(pointTags, tag)
%ADDBSPLINE  gmsh.model.geo.addBSpline
%   Add a cubic b-spline curve in the built-in CAD representation, with
%   `pointTags' control points. If `tag' is positive, set the tag explicitly;
%   otherwise a new tag is selected automatically. Creates a periodic curve if
%   the first and last points are the same. Return the tag of the b-spline
%   curve.
%
%   Inputs:
%     pointTags - vector of integers
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        pointTags
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddBSpline', pointTags, tag);
end
