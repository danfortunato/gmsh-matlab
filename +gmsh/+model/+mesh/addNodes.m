function addNodes(dim, tag, nodeTags, coord, parametricCoord)
%ADDNODES  gmsh.model.mesh.addNodes
%   Add nodes classified on the model entity of dimension `dim' and tag `tag'.
%   `nodeTags' contains the node tags (their unique, strictly positive
%   identification numbers). `coord' is a vector of length 3 times the length of
%   `nodeTags' that contains the x, y, z coordinates of the nodes, concatenated:
%   [n1x, n1y, n1z, n2x, ...]. The optional `parametricCoord' vector contains
%   the parametric coordinates of the nodes, if any. The length of
%   `parametricCoord' can be 0 or `dim' times the length of `nodeTags'. If the
%   `nodeTags' vector is empty, new tags are automatically assigned to the
%   nodes.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     nodeTags - vector of size_t
%     coord - vector of doubles
%     parametricCoord - vector of doubles (default [])

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        nodeTags
        coord
        parametricCoord = []
    end

    gmsh.internal.api.call('gmshModelMeshAddNodes', dim, tag, nodeTags, coord, parametricCoord);
end
