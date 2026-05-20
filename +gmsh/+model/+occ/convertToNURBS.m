function convertToNURBS(dimTags)
%CONVERTTONURBS  gmsh.model.occ.convertToNURBS
%   Convert the entities `dimTags' to NURBS.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)

    arguments
        dimTags
    end

    gmsh.internal.api.call('gmshModelOccConvertToNURBS', dimTags);
end
