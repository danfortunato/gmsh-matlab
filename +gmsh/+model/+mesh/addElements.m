function addElements(dim, tag, elementTypes, elementTags, nodeTags)
%ADDELEMENTS  gmsh.model.mesh.addElements
%   Add elements classified on the entity of dimension `dim' and tag `tag'.
%   `types' contains the MSH types of the elements (e.g. `2' for 3-node
%   triangles: see the Gmsh reference manual). `elementTags' is a vector of the
%   same length as `types'; each entry is a vector containing the tags (unique,
%   strictly positive identifiers) of the elements of the corresponding type.
%   `nodeTags' is also a vector of the same length as `types'; each entry is a
%   vector of length equal to the number of elements of the given type times the
%   number N of nodes per element, that contains the node tags of all the
%   elements of the given type, concatenated: [e1n1, e1n2, ..., e1nN, e2n1,
%   ...].
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     elementTypes - vector of integers
%     elementTags - cell of size_t vectors
%     nodeTags - cell of size_t vectors

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        elementTypes
        elementTags
        nodeTags
    end

    gmsh.internal.api.call('gmshModelMeshAddElements', dim, tag, elementTypes, elementTags, nodeTags);
end
