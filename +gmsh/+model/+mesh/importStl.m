function importStl()
%IMPORTSTL  gmsh.model.mesh.importStl
%   Import the model STL representation (if available) as the current mesh.

    gmsh.internal.api.call('gmshModelMeshImportStl');
end
