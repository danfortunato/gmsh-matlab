function ret = addSphere(xc, yc, zc, radius, tag, angle1, angle2, angle3)
%ADDSPHERE  gmsh.model.occ.addSphere
%   Add a sphere of center (`xc', `yc', `zc') and radius `r' in the OpenCASCADE
%   CAD representation. The optional `angle1' and `angle2' arguments define the
%   polar angle opening (from -Pi/2 to Pi/2). The optional `angle3' argument
%   defines the azimuthal opening (from 0 to 2*Pi). If `tag' is positive, set
%   the tag explicitly; otherwise a new tag is selected automatically. Return
%   the tag of the sphere.
%
%   Inputs:
%     xc - double scalar
%     yc - double scalar
%     zc - double scalar
%     radius - double scalar
%     tag - integer scalar (default -1)
%     angle1 - double scalar (default -pi/2)
%     angle2 - double scalar (default pi/2)
%     angle3 - double scalar (default 2*pi)
%
%   Outputs:
%     ret - integer scalar

    arguments
        xc (1,1) double
        yc (1,1) double
        zc (1,1) double
        radius (1,1) double
        tag (1,1) {mustBeInteger} = -1
        angle1 (1,1) double = -pi/2
        angle2 (1,1) double = pi/2
        angle3 (1,1) double = 2*pi
    end

    ret = gmsh.internal.api.call('gmshModelOccAddSphere', xc, yc, zc, radius, tag, angle1, angle2, angle3);
end
