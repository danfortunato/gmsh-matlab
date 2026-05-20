function triangles = triangulate(coordinates, edges)
%TRIANGULATE  gmsh.algorithm.triangulate
%   Triangulate the points given in the `coordinates' vector as concatenated
%   pairs of u, v coordinates, with (optional) constrained edges given in the
%   `edges' vector as pairs of indexes (with numbering starting at 1), and
%   return the triangles as concatenated triplets of point indexes (with
%   numbering starting at 1) in `triangles'.
%
%   Inputs:
%     coordinates - vector of doubles
%     edges - vector of size_t (default uint64([]))
%
%   Outputs:
%     triangles - row vector of uint64

    arguments
        coordinates
        edges = uint64([])
    end

    triangles = gmsh.internal.api.call('gmshAlgorithmTriangulate', coordinates, edges);
end
