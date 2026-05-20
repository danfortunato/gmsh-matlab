function normals = getNormal(tag, parametricCoord)
%GETNORMAL  gmsh.model.getNormal
%   Get the normal to the surface with tag `tag' at the parametric coordinates
%   `parametricCoord'. The `parametricCoord' vector should contain u and v
%   coordinates, concatenated: [p1u, p1v, p2u, ...]. `normals' are returned as a
%   vector of x, y, z components, concatenated: [n1x, n1y, n1z, n2x, ...].
%
%   Inputs:
%     tag - integer scalar
%     parametricCoord - vector of doubles
%
%   Outputs:
%     normals - row vector of doubles

    arguments
        tag (1,1) {mustBeInteger}
        parametricCoord
    end

    normals = gmsh.internal.api.call('gmshModelGetNormal', tag, parametricCoord);
end
