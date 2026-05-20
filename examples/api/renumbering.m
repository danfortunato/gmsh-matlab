gmsh.initialize();
gmsh.option.setNumber("Mesh.MeshSizeMax", 0.2);
gmsh.option.setNumber("Mesh.MeshSizeMin", 0.2);
gmsh.option.setNumber("Mesh.NodeLabels", 1);

gmsh.model.occ.addRectangle(0, 0, 0, 1, 1);
gmsh.model.occ.synchronize();

gmsh.model.mesh.generate();

[old, new] = gmsh.model.mesh.computeRenumbering('RCMK');
gmsh.model.mesh.renumberNodes(old, new);

[old, new] = gmsh.model.mesh.computeRenumbering('Hilbert');
gmsh.model.mesh.renumberNodes(old, new);

[old, new] = gmsh.model.mesh.computeRenumbering('Metis');
gmsh.model.mesh.renumberNodes(old, new);

gmsh.finalize();
