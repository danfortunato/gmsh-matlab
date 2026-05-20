function ret = getMaxTag(dim)
%GETMAXTAG  gmsh.model.occ.getMaxTag
%   Get the maximum tag of entities of dimension `dim' in the OpenCASCADE CAD
%   representation.
%
%   Inputs:
%     dim - integer scalar
%
%   Outputs:
%     ret - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
    end

    ret = gmsh.internal.api.call('gmshModelOccGetMaxTag', dim);
end
