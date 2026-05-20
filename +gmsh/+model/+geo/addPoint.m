function ret = addPoint(x, y, z, meshSize, tag)
%ADDPOINT  gmsh.model.geo.addPoint
%   Add a geometrical point in the built-in CAD representation, at coordinates
%   (`x', `y', `z'). If `meshSize' is > 0, add a meshing constraint at that
%   point. If `tag' is positive, set the tag explicitly; otherwise a new tag is
%   selected automatically. Return the tag of the point. (Note that the point
%   will be added in the current model only after `synchronize' is called. This
%   behavior holds for all the entities added in the geo module.)
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     meshSize - double scalar (default 0.)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        meshSize (1,1) double = 0.
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddPoint', x, y, z, meshSize, tag);
end
