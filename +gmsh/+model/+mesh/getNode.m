function [coord, parametricCoord, dim, tag] = getNode(nodeTag)
%GETNODE  gmsh.model.mesh.getNode
%   Get the coordinates and the parametric coordinates (if any) of the node with
%   tag `tag', as well as the dimension `dim' and tag `tag' of the entity on
%   which the node is classified. This function relies on an internal cache (a
%   vector in case of dense node numbering, a map otherwise); for large meshes
%   accessing nodes in bulk is often preferable.
%
%   Inputs:
%     nodeTag - size_t scalar
%
%   Outputs:
%     coord - row vector of doubles
%     parametricCoord - row vector of doubles
%     dim - integer scalar
%     tag - integer scalar

    arguments
        nodeTag (1,1) {mustBeInteger, mustBeNonnegative}
    end

    [coord, parametricCoord, dim, tag] = gmsh.internal.api.call('gmshModelMeshGetNode', nodeTag);
end
