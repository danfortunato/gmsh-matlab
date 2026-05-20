function ret = addGeometry(geometry, numbers, strings, tag)
%ADDGEOMETRY  gmsh.model.geo.addGeometry
%   Add a `geometry' in the built-in CAD representation. `geometry' can
%   currently be one of "Sphere" or "PolarSphere" (where `numbers' should
%   contain the x, y, z coordinates of the center, followed by the radius), or
%   "ParametricSurface" (where `strings' should contains three expression
%   evaluating to the x, y and z coordinates in terms of parametric coordinates
%   u and v). If `tag' is positive, set the tag of the geometry explicitly;
%   otherwise a new tag is selected automatically. Return the tag of the
%   geometry.
%
%   Inputs:
%     geometry - string
%     numbers - vector of doubles (default [])
%     strings - cell of strings (default {})
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        geometry (1,:) char
        numbers = []
        strings = {}
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddGeometry', geometry, numbers, strings, tag);
end
