function ret = addBezier(pointTags, tag)
%ADDBEZIER  gmsh.model.geo.addBezier
%   Add a Bezier curve in the built-in CAD representation, with `pointTags'
%   control points. If `tag' is positive, set the tag explicitly; otherwise a
%   new tag is selected automatically.  Return the tag of the Bezier curve.
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

    ret = gmsh.internal.api.call('gmshModelGeoAddBezier', pointTags, tag);
end
