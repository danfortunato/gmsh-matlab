function nodeTags = getElementEdgeNodes(elementType, tag, primary, task, numTasks)
%GETELEMENTEDGENODES  gmsh.model.mesh.getElementEdgeNodes
%   Get the nodes on the edges of all elements of type `elementType' classified
%   on the entity of tag `tag'. `nodeTags' contains the node tags of the edges
%   for all the elements: [e1a1n1, e1a1n2, e1a2n1, ...]. Data is returned by
%   element, with elements in the same order as in `getElements' and
%   `getElementsByType'. If `primary' is set, only the primary (begin/end) nodes
%   of the edges are returned. If `tag' < 0, get the edge nodes for all
%   entities. If `numTasks' > 1, only compute and return the part of the data
%   indexed by `task' (for C++ only; output vector must be preallocated).
%
%   Inputs:
%     elementType - integer scalar
%     tag - integer scalar (default -1)
%     primary - logical scalar (default false)
%     task - size_t scalar (default 0)
%     numTasks - size_t scalar (default 1)
%
%   Outputs:
%     nodeTags - row vector of uint64

    arguments
        elementType (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        primary (1,1) logical = false
        task (1,1) {mustBeInteger, mustBeNonnegative} = 0
        numTasks (1,1) {mustBeInteger, mustBeNonnegative} = 1
    end

    nodeTags = gmsh.internal.api.call('gmshModelMeshGetElementEdgeNodes', elementType, tag, primary, task, numTasks);
end
