function [elementTags, partitions] = getGhostElements(dim, tag)
%GETGHOSTELEMENTS  gmsh.model.mesh.getGhostElements
%   Get the ghost elements `elementTags' and their associated `partitions'
%   stored in the ghost entity of dimension `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     elementTags - row vector of uint64
%     partitions - row vector of int32

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [elementTags, partitions] = gmsh.internal.api.call('gmshModelMeshGetGhostElements', dim, tag);
end
