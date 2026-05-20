function ret = addEllipse(x, y, z, r1, r2, tag, angle1, angle2, zAxis, xAxis)
%ADDELLIPSE  gmsh.model.occ.addEllipse
%   Add an ellipse of center (`x', `y', `z') and radii `r1' and `r2' (with `r1'
%   >= `r2') along the x- and y-axes, respectively, in the OpenCASCADE CAD
%   representation. If `tag' is positive, set the tag explicitly; otherwise a
%   new tag is selected automatically. If `angle1' and `angle2' are specified,
%   create an ellipse arc between the two angles. If a vector `zAxis' of size 3
%   is provided, use it as the normal to the ellipse plane (z-axis). If a vector
%   `xAxis' of size 3 is provided in addition to `zAxis', use it to define the
%   x-axis. Return the tag of the ellipse.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     r1 - double scalar
%     r2 - double scalar
%     tag - integer scalar (default -1)
%     angle1 - double scalar (default 0.)
%     angle2 - double scalar (default 2*pi)
%     zAxis - vector of doubles (default [])
%     xAxis - vector of doubles (default [])
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
        angle1 (1,1) double = 0.
        angle2 (1,1) double = 2*pi
        zAxis = []
        xAxis = []
    end

    ret = gmsh.internal.api.call('gmshModelOccAddEllipse', x, y, z, r1, r2, tag, angle1, angle2, zAxis, xAxis);
end
