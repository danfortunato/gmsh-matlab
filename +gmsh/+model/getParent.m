function [parentDim, parentTag] = getParent(dim, tag)
%GETPARENT  gmsh.model.getParent
%   In a partitioned model, get the parent of the entity of dimension `dim' and
%   tag `tag', i.e. from which the entity is a part of, if any. `parentDim' and
%   `parentTag' are set to -1 if the entity has no parent.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     parentDim - integer scalar
%     parentTag - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [parentDim, parentTag] = gmsh.internal.api.call('gmshModelGetParent', dim, tag);
end
