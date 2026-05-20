function ret = addLine(startTag, endTag, tag)
%ADDLINE  gmsh.model.geo.addLine
%   Add a straight line segment in the built-in CAD representation, between the
%   two points with tags `startTag' and `endTag'. If `tag' is positive, set the
%   tag explicitly; otherwise a new tag is selected automatically. Return the
%   tag of the line.
%
%   Inputs:
%     startTag - integer scalar
%     endTag - integer scalar
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        startTag (1,1) {mustBeInteger}
        endTag (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddLine', startTag, endTag, tag);
end
