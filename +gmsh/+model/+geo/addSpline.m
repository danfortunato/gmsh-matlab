function ret = addSpline(pointTags, tag)
%ADDSPLINE  gmsh.model.geo.addSpline
%   Add a spline (Catmull-Rom) curve in the built-in CAD representation, going
%   through the points `pointTags'. If `tag' is positive, set the tag
%   explicitly; otherwise a new tag is selected automatically. Create a periodic
%   curve if the first and last points are the same. Return the tag of the
%   spline curve.
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

    ret = gmsh.internal.api.call('gmshModelGeoAddSpline', pointTags, tag);
end
