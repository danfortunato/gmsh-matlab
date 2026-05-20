function outDimTags = copy(dimTags)
%COPY  gmsh.model.occ.copy
%   Copy the entities `dimTags' in the OpenCASCADE CAD representation; the new
%   entities are returned in `outDimTags'.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccCopy', dimTags);
end
