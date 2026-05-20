gmsh.initialize();
gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
gmsh.model.occ.addBox(1, 0, 0, 1, 1, 1);
gmsh.model.occ.removeAllDuplicates();
gmsh.model.occ.synchronize();

gmsh.model.mesh.generate(3);

% Mesh.MeshOnlyVisible can be used to selectively re-mesh / re-order parts.
gmsh.option.setNumber('Mesh.MeshOnlyVisible', 1);
gmsh.model.setVisibility([3, 2], 0, true);

gmsh.model.mesh.setOrder(2);  % only on volume 1
gmsh.model.setVisibility([3, 2], 1, true);

gmsh.finalize();
