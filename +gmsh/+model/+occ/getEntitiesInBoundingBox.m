function dimTags = getEntitiesInBoundingBox(xmin, ymin, zmin, xmax, ymax, zmax, dim)
%GETENTITIESINBOUNDINGBOX  gmsh.model.occ.getEntitiesInBoundingBox
%   Get the OpenCASCADE entities in the bounding box defined by the two points
%   (`xmin', `ymin', `zmin') and (`xmax', `ymax', `zmax'). If `dim' is >= 0,
%   return only the entities of the specified dimension (e.g. points if `dim' ==
%   0).
%
%   Inputs:
%     xmin - double scalar
%     ymin - double scalar
%     zmin - double scalar
%     xmax - double scalar
%     ymax - double scalar
%     zmax - double scalar
%     dim - integer scalar (default -1)
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        xmin (1,1) double
        ymin (1,1) double
        zmin (1,1) double
        xmax (1,1) double
        ymax (1,1) double
        zmax (1,1) double
        dim (1,1) {mustBeInteger} = -1
    end

    dimTags = gmsh.internal.api.call('gmshModelOccGetEntitiesInBoundingBox', xmin, ymin, zmin, xmax, ymax, zmax, dim);
end
