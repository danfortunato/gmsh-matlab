function [elementTypes, elementTags, nodeTags] = getElements(dim, tag)
%GETELEMENTS  gmsh.model.mesh.getElements
%   Get the elements classified on the entity of dimension `dim' and tag `tag'.
%   If `tag' < 0, get the elements for all entities of dimension `dim'. If `dim'
%   and `tag' are negative, get all the elements in the mesh. `elementTypes'
%   contains the MSH types of the elements (e.g. `2' for 3-node triangles: see
%   `getElementProperties' to obtain the properties for a given element type).
%   `elementTags' is a vector of the same length as `elementTypes'; each entry
%   is a vector containing the tags (unique, strictly positive identifiers) of
%   the elements of the corresponding type. `nodeTags' is also a vector of the
%   same length as `elementTypes'; each entry is a vector of length equal to the
%   number of elements of the given type times the number N of nodes for this
%   type of element, that contains the node tags of all the elements of the
%   given type, concatenated: [e1n1, e1n2, ..., e1nN, e2n1, ...].
%
%   Inputs:
%     dim - integer scalar (default -1)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     elementTypes - row vector of int32
%     elementTags - cell of uint64 row vectors
%     nodeTags - cell of uint64 row vectors

    arguments
        dim (1,1) {mustBeInteger} = -1
        tag (1,1) {mustBeInteger} = -1
    end

    [elementTypes, elementTags, nodeTags] = gmsh.internal.api.call('gmshModelMeshGetElements', dim, tag);
end
