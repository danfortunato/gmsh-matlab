function surfaceParametricCoord = reparametrizeOnSurface(dim, tag, parametricCoord, surfaceTag, which)
%REPARAMETRIZEONSURFACE  gmsh.model.reparametrizeOnSurface
%   Reparametrize the boundary entity (point or curve, i.e. with `dim' == 0 or
%   `dim' == 1) of tag `tag' on the surface `surfaceTag'. If `dim' == 1,
%   reparametrize all the points corresponding to the parametric coordinates
%   `parametricCoord'. Multiple matches in case of periodic surfaces can be
%   selected with `which'. This feature is only available for a subset of
%   entities, depending on the underlying geometrical representation.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     parametricCoord - vector of doubles
%     surfaceTag - integer scalar
%     which - integer scalar (default 0)
%
%   Outputs:
%     surfaceParametricCoord - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        parametricCoord
        surfaceTag (1,1) {mustBeInteger}
        which (1,1) {mustBeInteger} = 0
    end

    surfaceParametricCoord = gmsh.internal.api.call('gmshModelReparametrizeOnSurface', dim, tag, parametricCoord, surfaceTag, which);
end
