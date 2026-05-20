function removeElements(dim, tag, elementTags)
%REMOVEELEMENTS  gmsh.model.mesh.removeElements
%   Remove the elements with tags `elementTags' from the entity of dimension
%   `dim' and tag `tag'. If `elementTags' is empty, remove all the elements
%   classified on the entity. To get consistent node classification on model
%   entities, `reclassifyNodes()' should be called afterwards.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     elementTags - vector of size_t (default uint64([]))

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        elementTags = uint64([])
    end

    gmsh.internal.api.call('gmshModelMeshRemoveElements', dim, tag, elementTags);
end
