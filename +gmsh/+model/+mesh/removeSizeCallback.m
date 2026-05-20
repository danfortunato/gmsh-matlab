function removeSizeCallback()
%REMOVESIZECALLBACK  gmsh.model.mesh.removeSizeCallback
%   Remove the mesh size callback from the current model.

    gmsh.internal.api.call('gmshModelMeshRemoveSizeCallback');
end
