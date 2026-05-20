function nodeTags = getLastNodeError()
%GETLASTNODEERROR  gmsh.model.mesh.getLastNodeError
%   Get the last node tags `nodeTags' where a meshing error occurred. Currently
%   only populated by the new 3D meshing algorithms.
%
%   Outputs:
%     nodeTags - row vector of uint64

    nodeTags = gmsh.internal.api.call('gmshModelMeshGetLastNodeError');
end
