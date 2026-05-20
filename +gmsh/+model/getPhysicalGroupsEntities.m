function [dimTags, entities] = getPhysicalGroupsEntities(dim)
%GETPHYSICALGROUPSENTITIES  gmsh.model.getPhysicalGroupsEntities
%   Get the physical groups in the current model as well as the model entities
%   that make them up. The physical groups are returned as the vector of (dim,
%   tag) pairs `dimTags'. The model entities making up the corresponding
%   physical groups are returned in `entities'. If `dim' is >= 0, return only
%   the groups of the specified dimension (e.g. physical points if `dim' == 0).
%
%   Inputs:
%     dim - integer scalar (default -1)
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs
%     entities - cell of Nx2 (dim,tag) matrices

    arguments
        dim (1,1) {mustBeInteger} = -1
    end

    [dimTags, entities] = gmsh.internal.api.call('gmshModelGetPhysicalGroupsEntities', dim);
end
