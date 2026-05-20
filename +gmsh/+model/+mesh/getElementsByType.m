function [elementTags, nodeTags] = getElementsByType(elementType, tag, task, numTasks)
%GETELEMENTSBYTYPE  gmsh.model.mesh.getElementsByType
%   Get the elements of type `elementType' classified on the entity of tag
%   `tag'. If `tag' < 0, get the elements for all entities. `elementTags' is a
%   vector containing the tags (unique, strictly positive identifiers) of the
%   elements of the corresponding type. `nodeTags' is a vector of length equal
%   to the number of elements of the given type times the number N of nodes for
%   this type of element, that contains the node tags of all the elements of the
%   given type, concatenated: [e1n1, e1n2, ..., e1nN, e2n1, ...]. If `numTasks'
%   > 1, only compute and return the part of the data indexed by `task' (for C++
%   only; output vectors must be preallocated).
%
%   Inputs:
%     elementType - integer scalar
%     tag - integer scalar (default -1)
%     task - size_t scalar (default 0)
%     numTasks - size_t scalar (default 1)
%
%   Outputs:
%     elementTags - row vector of uint64
%     nodeTags - row vector of uint64

    arguments
        elementType (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        task (1,1) {mustBeInteger, mustBeNonnegative} = 0
        numTasks (1,1) {mustBeInteger, mustBeNonnegative} = 1
    end

    [elementTags, nodeTags] = gmsh.internal.api.call('gmshModelMeshGetElementsByType', elementType, tag, task, numTasks);
end
