function basisFunctionsOrientation = getBasisFunctionsOrientation(elementType, functionSpaceType, tag, task, numTasks)
%GETBASISFUNCTIONSORIENTATION  gmsh.model.mesh.getBasisFunctionsOrientation
%   Get the orientation index of the elements of type `elementType' in the
%   entity of tag `tag'. The arguments have the same meaning as in
%   `getBasisFunctions'. `basisFunctionsOrientation' is a vector giving for each
%   element the orientation index in the values returned by `getBasisFunctions'.
%   For Lagrange basis functions the call is superfluous as it will return a
%   vector of zeros. If `numTasks' > 1, only compute and return the part of the
%   data indexed by `task' (for C++ only; output vector must be preallocated).
%
%   Inputs:
%     elementType - integer scalar
%     functionSpaceType - string
%     tag - integer scalar (default -1)
%     task - size_t scalar (default 0)
%     numTasks - size_t scalar (default 1)
%
%   Outputs:
%     basisFunctionsOrientation - row vector of int32

    arguments
        elementType (1,1) {mustBeInteger}
        functionSpaceType (1,:) char
        tag (1,1) {mustBeInteger} = -1
        task (1,1) {mustBeInteger, mustBeNonnegative} = 0
        numTasks (1,1) {mustBeInteger, mustBeNonnegative} = 1
    end

    basisFunctionsOrientation = gmsh.internal.api.call('gmshModelMeshGetBasisFunctionsOrientation', elementType, functionSpaceType, tag, task, numTasks);
end
