function ret = fillet2D(edgeTag1, edgeTag2, radius, tag, pointTag, reverse)
%FILLET2D  gmsh.model.occ.fillet2D
%   Create a fillet edge between edges `edgeTag1' and `edgeTag2' with radius
%   `radius'. The modifed edges keep their tag. If `tag' is positive, set the
%   tag explicitly; otherwise a new tag is selected automatically. If `pointTag'
%   is positive, set the point on the edge at which the fillet is created. If
%   `reverse' is set, the normal of the plane through the two planes is reversed
%   before the fillet is created.
%
%   Inputs:
%     edgeTag1 - integer scalar
%     edgeTag2 - integer scalar
%     radius - double scalar
%     tag - integer scalar (default -1)
%     pointTag - integer scalar (default -1)
%     reverse - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        edgeTag1 (1,1) {mustBeInteger}
        edgeTag2 (1,1) {mustBeInteger}
        radius (1,1) double
        tag (1,1) {mustBeInteger} = -1
        pointTag (1,1) {mustBeInteger} = -1
        reverse (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelOccFillet2D', edgeTag1, edgeTag2, radius, tag, pointTag, reverse);
end
