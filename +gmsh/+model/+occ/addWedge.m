function ret = addWedge(x, y, z, dx, dy, dz, tag, ltx, zAxis)
%ADDWEDGE  gmsh.model.occ.addWedge
%   Add a right angular wedge in the OpenCASCADE CAD representation, defined by
%   the right-angle point (`x', `y', `z') and the 3 extends along the x-, y- and
%   z-axes (`dx', `dy', `dz'). If `tag' is positive, set the tag explicitly;
%   otherwise a new tag is selected automatically. The optional argument `ltx'
%   defines the top extent along the x-axis. If a vector `zAxis' of size 3 is
%   provided, use it to define the z-axis. Return the tag of the wedge.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dx - double scalar
%     dy - double scalar
%     dz - double scalar
%     tag - integer scalar (default -1)
%     ltx - double scalar (default 0.)
%     zAxis - vector of doubles (default [])
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
        tag (1,1) {mustBeInteger} = -1
        ltx (1,1) double = 0.
        zAxis = []
    end

    ret = gmsh.internal.api.call('gmshModelOccAddWedge', x, y, z, dx, dy, dz, tag, ltx, zAxis);
end
