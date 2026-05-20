function rotate(dimTags, x, y, z, ax, ay, az, angle)
%ROTATE  gmsh.model.geo.rotate
%   Rotate the entities `dimTags' (given as a vector of (dim, tag) pairs) in the
%   built-in CAD representation by `angle' radians around the axis of revolution
%   defined by the point (`x', `y', `z') and the direction (`ax', `ay', `az').
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     ax - double scalar
%     ay - double scalar
%     az - double scalar
%     angle - double scalar

    arguments
        dimTags
        x (1,1) double
        y (1,1) double
        z (1,1) double
        ax (1,1) double
        ay (1,1) double
        az (1,1) double
        angle (1,1) double
    end

    gmsh.internal.api.call('gmshModelGeoRotate', dimTags, x, y, z, ax, ay, az, angle);
end
