gmsh.initialize();

gmsh.model.add("my model");
gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.setSize(gmsh.model.getEntities(0), 0.1);
gmsh.model.mesh.setSize([0, 1], 0.01);
gmsh.model.mesh.generate(3);

[~, eleTags, ~] = gmsh.model.mesh.getElements(3);
q = gmsh.model.mesh.getElementQualities(eleTags{1}, "volume");

t = gmsh.view.add("Element sizes");
gmsh.view.addHomogeneousModelData(t, 0, "my model", "ElementData", eleTags{1}, q);

gmsh.finalize();
