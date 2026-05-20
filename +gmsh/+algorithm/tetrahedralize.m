function [tetrahedra, steiner] = tetrahedralize(coordinates, triangles)
%TETRAHEDRALIZE  gmsh.algorithm.tetrahedralize
%   Tetrahedralize the points given in the `coordinates' vector as concatenated
%   triplets of x, y, z coordinates, with (optional) constrained triangles given
%   in the `triangles' vector as triplets of indexes (with numbering starting at
%   1), and return the tetrahedra as concatenated quadruplets of point indexes
%   (with numbering starting at 1) in `tetrahedra'. Steiner points might be
%   added in the `steiner' vector.
%
%   Inputs:
%     coordinates - vector of doubles
%     triangles - vector of size_t (default uint64([]))
%
%   Outputs:
%     tetrahedra - row vector of uint64
%     steiner - row vector of doubles

    arguments
        coordinates
        triangles = uint64([])
    end

    [tetrahedra, steiner] = gmsh.internal.api.call('gmshAlgorithmTetrahedralize', coordinates, triangles);
end
