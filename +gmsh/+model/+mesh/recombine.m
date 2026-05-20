function recombine()
%RECOMBINE  gmsh.model.mesh.recombine
%   Recombine the mesh of the current model.

    gmsh.internal.api.call('gmshModelMeshRecombine');
end
