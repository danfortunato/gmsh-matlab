function unpartition()
%UNPARTITION  gmsh.model.mesh.unpartition
%   Unpartition the mesh of the current model.

    gmsh.internal.api.call('gmshModelMeshUnpartition');
end
