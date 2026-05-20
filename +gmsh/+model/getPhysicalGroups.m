function dimTags = getPhysicalGroups(dim)
%GETPHYSICALGROUPS  gmsh.model.getPhysicalGroups
%   Get the physical groups in the current model. The physical groups are
%   returned as a vector of (dim, tag) pairs. If `dim' is >= 0, return only the
%   groups of the specified dimension (e.g. physical points if `dim' == 0).
%
%   Inputs:
%     dim - integer scalar (default -1)
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dim (1,1) {mustBeInteger} = -1
    end

    dimTags = gmsh.internal.api.call('gmshModelGetPhysicalGroups', dim);
end
