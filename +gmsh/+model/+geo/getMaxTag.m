function ret = getMaxTag(dim)
%GETMAXTAG  gmsh.model.geo.getMaxTag
%   Get the maximum tag of entities of dimension `dim' in the built-in CAD
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

    ret = gmsh.internal.api.call('gmshModelGeoGetMaxTag', dim);
end
