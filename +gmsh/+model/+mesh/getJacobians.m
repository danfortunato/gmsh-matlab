function [jacobians, determinants, coord] = getJacobians(elementType, localCoord, tag, task, numTasks)
%GETJACOBIANS  gmsh.model.mesh.getJacobians
%   Get the Jacobians of all the elements of type `elementType' classified on
%   the entity of tag `tag', at the G evaluation points `localCoord' given as
%   concatenated u, v, w coordinates in the reference element [g1u, g1v, g1w,
%   ..., gGu, gGv, gGw]. Data is returned by element, with elements in the same
%   order as in `getElements' and `getElementsByType'. `jacobians' contains for
%   each element the 9 entries of the 3x3 Jacobian matrix at each evaluation
%   point. The matrix is returned by column: [e1g1Jxu, e1g1Jyu, e1g1Jzu,
%   e1g1Jxv, ..., e1g1Jzw, e1g2Jxu, ..., e1gGJzw, e2g1Jxu, ...], with Jxu =
%   dx/du, Jyu = dy/du, etc. `determinants' contains for each element the
%   determinant of the Jacobian matrix at each evaluation point: [e1g1, e1g2,
%   ... e1gG, e2g1, ...]. `coord' contains for each element the x, y, z
%   coordinates of the evaluation points. If `tag' < 0, get the Jacobian data
%   for all entities. If `numTasks' > 1, only compute and return the part of the
%   data indexed by `task' (for C++ only; output vectors must be preallocated).
%
%   Inputs:
%     elementType - integer scalar
%     localCoord - vector of doubles
%     tag - integer scalar (default -1)
%     task - size_t scalar (default 0)
%     numTasks - size_t scalar (default 1)
%
%   Outputs:
%     jacobians - row vector of doubles
%     determinants - row vector of doubles
%     coord - row vector of doubles

    arguments
        elementType (1,1) {mustBeInteger}
        localCoord
        tag (1,1) {mustBeInteger} = -1
        task (1,1) {mustBeInteger, mustBeNonnegative} = 0
        numTasks (1,1) {mustBeInteger, mustBeNonnegative} = 1
    end

    [jacobians, determinants, coord] = gmsh.internal.api.call('gmshModelMeshGetJacobians', elementType, localCoord, tag, task, numTasks);
end
