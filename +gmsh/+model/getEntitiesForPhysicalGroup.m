function tags = getEntitiesForPhysicalGroup(dim, tag)
%GETENTITIESFORPHYSICALGROUP  gmsh.model.getEntitiesForPhysicalGroup
%   Get the tags of the model entities making up the physical group of dimension
%   `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     tags - row vector of int32

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    tags = gmsh.internal.api.call('gmshModelGetEntitiesForPhysicalGroup', dim, tag);
end
