function ret = addCone(x, y, z, dx, dy, dz, r1, r2, tag, angle)
%ADDCONE  gmsh.model.occ.addCone
%   Add a cone in the OpenCASCADE CAD representation, defined by the center
%   (`x', `y', `z') of its first circular face, the 3 components of the vector
%   (`dx', `dy', `dz') defining its axis and the two radii `r1' and `r2' of the
%   faces (these radii can be zero). If `tag' is positive, set the tag
%   explicitly; otherwise a new tag is selected automatically. `angle' defines
%   the optional angular opening (from 0 to 2*Pi). Return the tag of the cone.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dx - double scalar
%     dy - double scalar
%     dz - double scalar
%     r1 - double scalar
%     r2 - double scalar
%     tag - integer scalar (default -1)
%     angle - double scalar (default 2*pi)
%
%   Outputs:
%     ret - integer scalar

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        dx (1,1) double
        dy (1,1) double
        dz (1,1) double
        r1 (1,1) double
        r2 (1,1) double
        tag (1,1) {mustBeInteger} = -1
        angle (1,1) double = 2*pi
    end

    ret = gmsh.internal.api.call('gmshModelOccAddCone', x, y, z, dx, dy, dz, r1, r2, tag, angle);
end
