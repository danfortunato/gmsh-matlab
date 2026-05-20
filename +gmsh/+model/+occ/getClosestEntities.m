function [outDimTags, distances, coord] = getClosestEntities(x, y, z, dimTags, n)
%GETCLOSESTENTITIES  gmsh.model.occ.getClosestEntities
%   Find the `n' closest entities to point (`x', `y', `z') amongst the entities
%   `dimTags'. Return the entities in `outDimTags' sorted by increasing
%   distance, the corresponding distances in `distances', and the correspdonding
%   closest x, y, z coordinates, concatenated, in `coord'.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dimTags - Nx2 matrix of (dim,tag)
%     n - integer scalar (default 1)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs
%     distances - row vector of doubles
%     coord - row vector of doubles

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        dimTags
        n (1,1) {mustBeInteger} = 1
    end

    [outDimTags, distances, coord] = gmsh.internal.api.call('gmshModelOccGetClosestEntities', x, y, z, dimTags, n);
end
