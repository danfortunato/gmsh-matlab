function tagMaster = getPeriodic(dim, tags)
%GETPERIODIC  gmsh.model.mesh.getPeriodic
%   Get master entities `tagsMaster' for the entities of dimension `dim' and
%   tags `tags'.
%
%   Inputs:
%     dim - integer scalar
%     tags - vector of integers
%
%   Outputs:
%     tagMaster - row vector of int32

    arguments
        dim (1,1) {mustBeInteger}
        tags
    end

    tagMaster = gmsh.internal.api.call('gmshModelMeshGetPeriodic', dim, tags);
end
