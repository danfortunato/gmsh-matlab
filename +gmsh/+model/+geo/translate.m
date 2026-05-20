function translate(dimTags, dx, dy, dz)
%TRANSLATE  gmsh.model.geo.translate
%   Translate the entities `dimTags' (given as a vector of (dim, tag) pairs) in
%   the built-in CAD representation along (`dx', `dy', `dz').
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     dx - double scalar
%     dy - double scalar
%     dz - double scalar

    arguments
        dimTags
        dx (1,1) double
        dy (1,1) double
        dz (1,1) double
    end

    gmsh.internal.api.call('gmshModelGeoTranslate', dimTags, dx, dy, dz);
end
