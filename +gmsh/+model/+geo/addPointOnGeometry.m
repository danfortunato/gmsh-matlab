function ret = addPointOnGeometry(geometryTag, x, y, z, meshSize, tag)
%ADDPOINTONGEOMETRY  gmsh.model.geo.addPointOnGeometry
%   Add a point in the built-in CAD representation, at coordinates (`x', `y',
%   `z') on the geometry `geometryTag'. If `meshSize' is > 0, add a meshing
%   constraint at that point. If `tag' is positive, set the tag explicitly;
%   otherwise a new tag is selected automatically. Return the tag of the point.
%   For surface geometries, only the `x' and `y' coordinates are used.
%
%   Inputs:
%     geometryTag - integer scalar
%     x - double scalar
%     y - double scalar
%     z - double scalar (default 0.)
%     meshSize - double scalar (default 0.)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        geometryTag (1,1) {mustBeInteger}
        x (1,1) double
        y (1,1) double
        z (1,1) double = 0.
        meshSize (1,1) double = 0.
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddPointOnGeometry', geometryTag, x, y, z, meshSize, tag);
end
