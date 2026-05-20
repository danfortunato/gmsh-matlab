function setInterpolationMatrices(tag, kind, d, coef, exp, dGeo, coefGeo, expGeo)
%SETINTERPOLATIONMATRICES  gmsh.view.setInterpolationMatrices
%   Set interpolation matrices for the element family `type' ("Line",
%   "Triangle", "Quadrangle", "Tetrahedron", "Hexahedron", "Prism", "Pyramid")
%   in the view `tag'. The approximation of the values over an element is
%   written as a linear combination of `d' basis functions f_i(u, v, w) = sum_(j
%   = 0, ..., `d' - 1) `coef'[i][j] u^`exp'[j][0] v^`exp'[j][1] w^`exp'[j][2], i
%   = 0, ..., `d'-1, with u, v, w the coordinates in the reference element. The
%   `coef' matrix (of size `d' x `d') and the `exp' matrix (of size `d' x 3) are
%   stored as vectors, by row. If `dGeo' is positive, use `coefGeo' and `expGeo'
%   to define the interpolation of the x, y, z coordinates of the element in
%   terms of the u, v, w coordinates, in exactly the same way. If `d' < 0,
%   remove the interpolation matrices.
%
%   Inputs:
%     tag - integer scalar
%     kind - string
%     d - integer scalar
%     coef - vector of doubles
%     exp - vector of doubles
%     dGeo - integer scalar (default 0)
%     coefGeo - vector of doubles (default [])
%     expGeo - vector of doubles (default [])

    arguments
        tag (1,1) {mustBeInteger}
        kind (1,:) char
        d (1,1) {mustBeInteger}
        coef
        exp
        dGeo (1,1) {mustBeInteger} = 0
        coefGeo = []
        expGeo = []
    end

    gmsh.internal.api.call('gmshViewSetInterpolationMatrices', tag, kind, d, coef, exp, dGeo, coefGeo, expGeo);
end
