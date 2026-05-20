function removePhysicalGroups(dimTags)
%REMOVEPHYSICALGROUPS  gmsh.model.removePhysicalGroups
%   Remove the physical groups `dimTags' (given as a vector of (dim, tag) pairs)
%   from the current model. If `dimTags' is empty, remove all groups.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelRemovePhysicalGroups', dimTags);
end
