function ret = addCircleArc(startTag, centerTag, endTag, tag, nx, ny, nz)
%ADDCIRCLEARC  gmsh.model.geo.addCircleArc
%   Add a circle arc (strictly smaller than Pi) in the built-in CAD
%   representation, between the two points with tags `startTag' and `endTag',
%   and with center `centerTag'. If `tag' is positive, set the tag explicitly;
%   otherwise a new tag is selected automatically. If (`nx', `ny', `nz') != (0,
%   0, 0), explicitly set the plane of the circle arc. Return the tag of the
%   circle arc.
%
%   Inputs:
%     startTag - integer scalar
%     centerTag - integer scalar
%     endTag - integer scalar
%     tag - integer scalar (default -1)
%     nx - double scalar (default 0.)
%     ny - double scalar (default 0.)
%     nz - double scalar (default 0.)
%
%   Outputs:
%     ret - integer scalar

    arguments
        startTag (1,1) {mustBeInteger}
        centerTag (1,1) {mustBeInteger}
        endTag (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        nx (1,1) double = 0.
        ny (1,1) double = 0.
        nz (1,1) double = 0.
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddCircleArc', startTag, centerTag, endTag, tag, nx, ny, nz);
end
