function curveTags = splitCurve(tag, pointTags)
%SPLITCURVE  gmsh.model.geo.splitCurve
%   Split the curve of tag `tag' in the built-in CAD representation, on the
%   specified control points `pointTags'. This feature is only available for
%   splines and b-splines. Return the tag(s) `curveTags' of the newly created
%   curve(s).
%
%   Inputs:
%     tag - integer scalar
%     pointTags - vector of integers
%
%   Outputs:
%     curveTags - row vector of int32

    arguments
        tag (1,1) {mustBeInteger}
        pointTags
    end

    curveTags = gmsh.internal.api.call('gmshModelGeoSplitCurve', tag, pointTags);
end
