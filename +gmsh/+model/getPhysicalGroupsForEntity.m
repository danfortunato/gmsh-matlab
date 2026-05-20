function physicalTags = getPhysicalGroupsForEntity(dim, tag)
%GETPHYSICALGROUPSFORENTITY  gmsh.model.getPhysicalGroupsForEntity
%   Get the tags of the physical groups (if any) to which the model entity of
%   dimension `dim' and tag `tag' belongs.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     physicalTags - row vector of int32

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    physicalTags = gmsh.internal.api.call('gmshModelGetPhysicalGroupsForEntity', dim, tag);
end
