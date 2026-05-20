function ret = addDisk(xc, yc, zc, rx, ry, tag, zAxis, xAxis)
%ADDDISK  gmsh.model.occ.addDisk
%   Add a disk in the OpenCASCADE CAD representation, with center (`xc', `yc',
%   `zc') and radius `rx' along the x-axis and `ry' along the y-axis (`rx' >=
%   `ry'). If `tag' is positive, set the tag explicitly; otherwise a new tag is
%   selected automatically. If a vector `zAxis' of size 3 is provided, use it as
%   the normal to the disk (z-axis). If a vector `xAxis' of size 3 is provided
%   in addition to `zAxis', use it to define the x-axis. Return the tag of the
%   disk.
%
%   Inputs:
%     xc - double scalar
%     yc - double scalar
%     zc - double scalar
%     rx - double scalar
%     ry - double scalar
%     tag - integer scalar (default -1)
%     zAxis - vector of doubles (default [])
%     xAxis - vector of doubles (default [])
%
%   Outputs:
%     ret - integer scalar

    arguments
        xc (1,1) double
        yc (1,1) double
        zc (1,1) double
        rx (1,1) double
        ry (1,1) double
        tag (1,1) {mustBeInteger} = -1
        zAxis = []
        xAxis = []
    end

    ret = gmsh.internal.api.call('gmshModelOccAddDisk', xc, yc, zc, rx, ry, tag, zAxis, xAxis);
end
