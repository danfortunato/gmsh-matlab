function symmetrize(dimTags, a, b, c, d)
%SYMMETRIZE  gmsh.model.geo.symmetrize
%   Mirror the entities `dimTags' (given as a vector of (dim, tag) pairs) in the
%   built-in CAD representation, with respect to the plane of equation `a' * x +
%   `b' * y + `c' * z + `d' = 0. (This is a deprecated synonym for `mirror'.)
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     a - double scalar
%     b - double scalar
%     c - double scalar
%     d - double scalar

    arguments
        dimTags
        a (1,1) double
        b (1,1) double
        c (1,1) double
        d (1,1) double
    end

    gmsh.internal.api.call('gmshModelGeoSymmetrize', dimTags, a, b, c, d);
end
