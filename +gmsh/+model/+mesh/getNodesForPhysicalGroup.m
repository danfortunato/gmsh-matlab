function [nodeTags, coord] = getNodesForPhysicalGroup(dim, tag)
%GETNODESFORPHYSICALGROUP  gmsh.model.mesh.getNodesForPhysicalGroup
%   Get the nodes from all the elements belonging to the physical group of
%   dimension `dim' and tag `tag'. `nodeTags' contains the node tags; `coord' is
%   a vector of length 3 times the length of `nodeTags' that contains the x, y,
%   z coordinates of the nodes, concatenated: [n1x, n1y, n1z, n2x, ...].
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     nodeTags - row vector of uint64
%     coord - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [nodeTags, coord] = gmsh.internal.api.call('gmshModelMeshGetNodesForPhysicalGroup', dim, tag);
end
