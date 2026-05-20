function ret = addCylinder(x, y, z, dx, dy, dz, r, tag, angle)
%ADDCYLINDER  gmsh.model.occ.addCylinder
%   Add a cylinder in the OpenCASCADE CAD representation, defined by the center
%   (`x', `y', `z') of its first circular face, the 3 components (`dx', `dy',
%   `dz') of the vector defining its axis and its radius `r'. The optional
%   `angle' argument defines the angular opening (from 0 to 2*Pi). If `tag' is
%   positive, set the tag explicitly; otherwise a new tag is selected
%   automatically. Return the tag of the cylinder.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dx - double scalar
%     dy - double scalar
%     dz - double scalar
%     r - double scalar
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
        r (1,1) double
        tag (1,1) {mustBeInteger} = -1
        angle (1,1) double = 2*pi
    end

    ret = gmsh.internal.api.call('gmshModelOccAddCylinder', x, y, z, dx, dy, dz, r, tag, angle);
end
