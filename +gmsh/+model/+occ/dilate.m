function dilate(dimTags, x, y, z, a, b, c)
%DILATE  gmsh.model.occ.dilate
%   Scale the entities `dimTags' (given as a vector of (dim, tag) pairs) in the
%   OpenCASCADE CAD representation by factors `a', `b' and `c' along the three
%   coordinate axes; use (`x', `y', `z') as the center of the homothetic
%   transformation.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     a - double scalar
%     b - double scalar
%     c - double scalar

    arguments
        dimTags
        x (1,1) double
        y (1,1) double
        z (1,1) double
        a (1,1) double
        b (1,1) double
        c (1,1) double
    end

    gmsh.internal.api.call('gmshModelOccDilate', dimTags, x, y, z, a, b, c);
end
