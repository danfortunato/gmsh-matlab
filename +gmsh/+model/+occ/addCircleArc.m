function ret = addCircleArc(startTag, middleTag, endTag, tag, center)
%ADDCIRCLEARC  gmsh.model.occ.addCircleArc
%   Add a circle arc in the OpenCASCADE CAD representation, between the two
%   points with tags `startTag' and `endTag', with middle point `middleTag'. If
%   `center' is true, the middle point is the center of the circle; otherwise
%   the circle goes through the middle point. If `tag' is positive, set the tag
%   explicitly; otherwise a new tag is selected automatically. Return the tag of
%   the circle arc.
%
%   Inputs:
%     startTag - integer scalar
%     middleTag - integer scalar
%     endTag - integer scalar
%     tag - integer scalar (default -1)
%     center - logical scalar (default true)
%
%   Outputs:
%     ret - integer scalar

    arguments
        startTag (1,1) {mustBeInteger}
        middleTag (1,1) {mustBeInteger}
        endTag (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        center (1,1) logical = true
    end

    ret = gmsh.internal.api.call('gmshModelOccAddCircleArc', startTag, middleTag, endTag, tag, center);
end
