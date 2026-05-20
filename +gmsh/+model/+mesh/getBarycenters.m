function barycenters = getBarycenters(elementType, tag, fast, primary, task, numTasks)
%GETBARYCENTERS  gmsh.model.mesh.getBarycenters
%   Get the barycenters of all elements of type `elementType' classified on the
%   entity of tag `tag'. If `primary' is set, only the primary nodes of the
%   elements are taken into account for the barycenter calculation. If `fast' is
%   set, the function returns the sum of the primary node coordinates (without
%   normalizing by the number of nodes). If `tag' < 0, get the barycenters for
%   all entities. If `numTasks' > 1, only compute and return the part of the
%   data indexed by `task' (for C++ only; output vector must be preallocated).
%
%   Inputs:
%     elementType - integer scalar
%     tag - integer scalar
%     fast - logical scalar
%     primary - logical scalar
%     task - size_t scalar (default 0)
%     numTasks - size_t scalar (default 1)
%
%   Outputs:
%     barycenters - row vector of doubles

    arguments
        elementType (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        fast (1,1) logical
        primary (1,1) logical
        task (1,1) {mustBeInteger, mustBeNonnegative} = 0
        numTasks (1,1) {mustBeInteger, mustBeNonnegative} = 1
    end

    barycenters = gmsh.internal.api.call('gmshModelMeshGetBarycenters', elementType, tag, fast, primary, task, numTasks);
end
