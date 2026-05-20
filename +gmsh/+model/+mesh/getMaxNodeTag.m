function maxTag = getMaxNodeTag()
%GETMAXNODETAG  gmsh.model.mesh.getMaxNodeTag
%   Get the maximum tag `maxTag' of a node in the mesh.
%
%   Outputs:
%     maxTag - size_t scalar

    maxTag = gmsh.internal.api.call('gmshModelMeshGetMaxNodeTag');
end
