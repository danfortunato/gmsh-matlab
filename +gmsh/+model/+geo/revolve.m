function outDimTags = revolve(dimTags, x, y, z, ax, ay, az, angle, numElements, heights, recombine)
%REVOLVE  gmsh.model.geo.revolve
%   Extrude the entities `dimTags' (given as a vector of (dim, tag) pairs) in
%   the built-in CAD representation, using a rotation of `angle' radians around
%   the axis of revolution defined by the point (`x', `y', `z') and the
%   direction (`ax', `ay', `az'). The angle should be strictly smaller than Pi.
%   Return extruded entities in `outDimTags'. If the `numElements' vector is not
%   empty, also extrude the mesh: the entries in `numElements' give the number
%   of elements in each layer. If the `height' vector is not empty, it provides
%   the (cumulative) height of the different layers, normalized to 1. If
%   `recombine' is set, recombine the mesh in the layers.
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
%     numElements - vector of integers (default int32([]))
%     heights - vector of doubles (default [])
%     recombine - logical scalar (default false)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags
        x (1,1) double
        y (1,1) double
        z (1,1) double
        ax (1,1) double
        ay (1,1) double
        az (1,1) double
        angle (1,1) double
        numElements = int32([])
        heights = []
        recombine (1,1) logical = false
    end

    outDimTags = gmsh.internal.api.call('gmshModelGeoRevolve', dimTags, x, y, z, ax, ay, az, angle, numElements, heights, recombine);
end
