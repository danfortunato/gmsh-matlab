function ret = addEllipseArc(startTag, centerTag, majorTag, endTag, tag)
%ADDELLIPSEARC  gmsh.model.occ.addEllipseArc
%   Add an ellipse arc in the OpenCASCADE CAD representation, between the two
%   points `startTag' and `endTag', and with center `centerTag' and major axis
%   point `majorTag'. If `tag' is positive, set the tag explicitly; otherwise a
%   new tag is selected automatically. Return the tag of the ellipse arc. Note
%   that OpenCASCADE does not allow creating ellipse arcs with the major radius
%   smaller than the minor radius.
%
%   Inputs:
%     startTag - integer scalar
%     centerTag - integer scalar
%     majorTag - integer scalar
%     endTag - integer scalar
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        startTag (1,1) {mustBeInteger}
        centerTag (1,1) {mustBeInteger}
        majorTag (1,1) {mustBeInteger}
        endTag (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelOccAddEllipseArc', startTag, centerTag, majorTag, endTag, tag);
end
