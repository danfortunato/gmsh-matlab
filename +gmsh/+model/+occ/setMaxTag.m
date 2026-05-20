function setMaxTag(dim, maxTag)
%SETMAXTAG  gmsh.model.occ.setMaxTag
%   Set the maximum tag `maxTag' for entities of dimension `dim' in the
%   OpenCASCADE CAD representation.
%
%   Inputs:
%     dim - integer scalar
%     maxTag - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        maxTag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelOccSetMaxTag', dim, maxTag);
end
