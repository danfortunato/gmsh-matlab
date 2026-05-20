function addElementsByType(tag, elementType, elementTags, nodeTags)
%ADDELEMENTSBYTYPE  gmsh.model.mesh.addElementsByType
%   Add elements of type `elementType' classified on the entity of tag `tag'.
%   `elementTags' contains the tags (unique, strictly positive identifiers) of
%   the elements of the corresponding type. `nodeTags' is a vector of length
%   equal to the number of elements times the number N of nodes per element,
%   that contains the node tags of all the elements, concatenated: [e1n1, e1n2,
%   ..., e1nN, e2n1, ...]. If the `elementTag' vector is empty, new tags are
%   automatically assigned to the elements.
%
%   Inputs:
%     tag - integer scalar
%     elementType - integer scalar
%     elementTags - vector of size_t
%     nodeTags - vector of size_t

    arguments
        tag (1,1) {mustBeInteger}
        elementType (1,1) {mustBeInteger}
        elementTags
        nodeTags
    end

    gmsh.internal.api.call('gmshModelMeshAddElementsByType', tag, elementType, elementTags, nodeTags);
end
