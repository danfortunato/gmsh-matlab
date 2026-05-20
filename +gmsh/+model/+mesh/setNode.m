function setNode(nodeTag, coord, parametricCoord)
%SETNODE  gmsh.model.mesh.setNode
%   Set the coordinates and the parametric coordinates (if any) of the node with
%   tag `tag'. This function relies on an internal cache (a vector in case of
%   dense node numbering, a map otherwise); for large meshes accessing nodes in
%   bulk is often preferable.
%
%   Inputs:
%     nodeTag - size_t scalar
%     coord - vector of doubles
%     parametricCoord - vector of doubles

    arguments
        nodeTag (1,1) {mustBeInteger, mustBeNonnegative}
        coord
        parametricCoord
    end

    gmsh.internal.api.call('gmshModelMeshSetNode', nodeTag, coord, parametricCoord);
end
