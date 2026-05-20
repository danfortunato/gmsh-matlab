function setMaxTag(dim, maxTag)
%SETMAXTAG  gmsh.model.geo.setMaxTag
%   Set the maximum tag `maxTag' for entities of dimension `dim' in the built-in
%   CAD representation.
%
%   Inputs:
%     dim - integer scalar
%     maxTag - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        maxTag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelGeoSetMaxTag', dim, maxTag);
end
