function [xmin, ymin, zmin, xmax, ymax, zmax] = getBoundingBox(dim, tag)
%GETBOUNDINGBOX  gmsh.model.occ.getBoundingBox
%   Get the bounding box (`xmin', `ymin', `zmin'), (`xmax', `ymax', `zmax') of
%   the OpenCASCADE entity of dimension `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     xmin - double scalar
%     ymin - double scalar
%     zmin - double scalar
%     xmax - double scalar
%     ymax - double scalar
%     zmax - double scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [xmin, ymin, zmin, xmax, ymax, zmax] = gmsh.internal.api.call('gmshModelOccGetBoundingBox', dim, tag);
end
