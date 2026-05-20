function maxTag = getMaxElementTag()
%GETMAXELEMENTTAG  gmsh.model.mesh.getMaxElementTag
%   Get the maximum tag `maxTag' of an element in the mesh.
%
%   Outputs:
%     maxTag - size_t scalar

    maxTag = gmsh.internal.api.call('gmshModelMeshGetMaxElementTag');
end
