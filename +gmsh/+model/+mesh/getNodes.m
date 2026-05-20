function [nodeTags, coord, parametricCoord] = getNodes(dim, tag, includeBoundary, returnParametricCoord)
%GETNODES  gmsh.model.mesh.getNodes
%   Get the nodes classified on the entity of dimension `dim' and tag `tag'. If
%   `tag' < 0, get the nodes for all entities of dimension `dim'. If `dim' and
%   `tag' are negative, get all the nodes in the mesh. `nodeTags' contains the
%   node tags (their unique, strictly positive identification numbers). `coord'
%   is a vector of length 3 times the length of `nodeTags' that contains the x,
%   y, z coordinates of the nodes, concatenated: [n1x, n1y, n1z, n2x, ...]. If
%   `dim' >= 0 and `returnParamtricCoord' is set, `parametricCoord' contains the
%   parametric coordinates ([u1, u2, ...] or [u1, v1, u2, ...]) of the nodes, if
%   available. The length of `parametricCoord' can be 0 or `dim' times the
%   length of `nodeTags'. If `includeBoundary' is set, also return the nodes
%   classified on the boundary of the entity (which will be reparametrized on
%   the entity if `dim' >= 0 in order to compute their parametric coordinates).
%
%   Inputs:
%     dim - integer scalar (default -1)
%     tag - integer scalar (default -1)
%     includeBoundary - logical scalar (default false)
%     returnParametricCoord - logical scalar (default true)
%
%   Outputs:
%     nodeTags - row vector of uint64
%     coord - row vector of doubles
%     parametricCoord - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger} = -1
        tag (1,1) {mustBeInteger} = -1
        includeBoundary (1,1) logical = false
        returnParametricCoord (1,1) logical = true
    end

    [nodeTags, coord, parametricCoord] = gmsh.internal.api.call('gmshModelMeshGetNodes', dim, tag, includeBoundary, returnParametricCoord);
end
