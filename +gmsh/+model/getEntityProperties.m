function [integers, reals] = getEntityProperties(dim, tag)
%GETENTITYPROPERTIES  gmsh.model.getEntityProperties
%   Get the properties of the entity of dimension `dim' and tag `tag'. The
%   `reals' vector contains the 4 coefficients of the cartesian equation for a
%   plane surface; the center coordinates, axis direction, major radius and
%   minor radius for a torus; the center coordinates, axis direction and radius
%   for a cylinder; the center coordinates, axis direction, radius and semi-
%   angle for surfaces of revolution; the center coordinates and the radius for
%   a sphere.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     integers - row vector of int32
%     reals - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [integers, reals] = gmsh.internal.api.call('gmshModelGetEntityProperties', dim, tag);
end
