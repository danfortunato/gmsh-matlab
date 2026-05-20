function outDimTags = copy(dimTags)
%COPY  gmsh.model.geo.copy
%   Copy the entities `dimTags' (given as a vector of (dim, tag) pairs) in the
%   built-in CAD representation; the new entities are returned in `outDimTags'.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags
    end

    outDimTags = gmsh.internal.api.call('gmshModelGeoCopy', dimTags);
end
