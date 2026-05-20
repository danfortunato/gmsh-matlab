function ret = addTorus(x, y, z, r1, r2, tag, angle, zAxis)
%ADDTORUS  gmsh.model.occ.addTorus
%   Add a torus in the OpenCASCADE CAD representation, defined by its center
%   (`x', `y', `z') and its 2 radii `r' and `r2'. If `tag' is positive, set the
%   tag explicitly; otherwise a new tag is selected automatically. The optional
%   argument `angle' defines the angular opening (from 0 to 2*Pi). If a vector
%   `zAxis' of size 3 is provided, use it to define the z-axis. Return the tag
%   of the torus.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     r1 - double scalar
%     r2 - double scalar
%     tag - integer scalar (default -1)
%     angle - double scalar (default 2*pi)
%     zAxis - vector of doubles (default [])
%
%   Outputs:
%     ret - integer scalar

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        r1 (1,1) double
        r2 (1,1) double
        tag (1,1) {mustBeInteger} = -1
        angle (1,1) double = 2*pi
        zAxis = []
    end

    ret = gmsh.internal.api.call('gmshModelOccAddTorus', x, y, z, r1, r2, tag, angle, zAxis);
end
