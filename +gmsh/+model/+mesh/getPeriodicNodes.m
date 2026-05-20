function [tagMaster, nodeTags, nodeTagsMaster, affineTransform] = getPeriodicNodes(dim, tag, includeHighOrderNodes)
%GETPERIODICNODES  gmsh.model.mesh.getPeriodicNodes
%   Get the master entity `tagMaster', the node tags `nodeTags' and their
%   corresponding master node tags `nodeTagsMaster', and the affine transform
%   `affineTransform' for the entity of dimension `dim' and tag `tag'. If
%   `includeHighOrderNodes' is set, include high-order nodes in the returned
%   data.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%     includeHighOrderNodes - logical scalar (default false)
%
%   Outputs:
%     tagMaster - integer scalar
%     nodeTags - row vector of uint64
%     nodeTagsMaster - row vector of uint64
%     affineTransform - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
        includeHighOrderNodes (1,1) logical = false
    end

    [tagMaster, nodeTags, nodeTagsMaster, affineTransform] = gmsh.internal.api.call('gmshModelMeshGetPeriodicNodes', dim, tag, includeHighOrderNodes);
end
