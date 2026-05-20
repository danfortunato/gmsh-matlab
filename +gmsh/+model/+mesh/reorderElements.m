function reorderElements(elementType, tag, ordering)
%REORDERELEMENTS  gmsh.model.mesh.reorderElements
%   Reorder the elements of type `elementType' classified on the entity of tag
%   `tag' according to the `ordering' vector.
%
%   Inputs:
%     elementType - integer scalar
%     tag - integer scalar
%     ordering - vector of size_t

    arguments
        elementType (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        ordering
    end

    gmsh.internal.api.call('gmshModelMeshReorderElements', elementType, tag, ordering);
end
