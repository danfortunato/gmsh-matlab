function refine()
%REFINE  gmsh.model.mesh.refine
%   Refine the mesh of the current model by uniformly splitting the elements.
%   This resets any high-order elements to order 1.

    gmsh.internal.api.call('gmshModelMeshRefine');
end
