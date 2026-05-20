gmsh.initialize();

gmsh.model.occ.addCircle(0, 0, 0, 0.2);
gmsh.model.occ.addCircle(1, 0, 0, 0.2, -1, 0., 2*pi, [0, 0,  1]);
gmsh.model.occ.addCircle(2, 0, 0, 0.2, -1, 0., 2*pi, [0, 0, -1], [1, 0, 0]);
gmsh.model.occ.addCircle(3, 0, 0, 0.2, -1, 0., 2*pi, [1, 1,  0], [0, 1, 0]);

gmsh.model.occ.addEllipse(0, -1, 0, 0.2, 0.1);
gmsh.model.occ.addEllipse(1, -1, 0, 0.2, 0.1, -1, 0., 2*pi, [1, 1, 0], [0, 1, 0]);
gmsh.model.occ.addEllipse(2, -1, 0, 0.2, 0.1, -1, 0., 2*pi, [1, 0, 0], [0, 1, 0]);

gmsh.model.occ.addDisk(0, -2, 0, 0.2, 0.1);
gmsh.model.occ.addDisk(1, -2, 0, 0.2, 0.1, -1, [1, 1, 0], [0, 1, 0]);

gmsh.model.occ.addTorus(0, -3, 0, 0.3, 0.1);
gmsh.model.occ.addTorus(1, -3, 0, 0.3, 0.1, -1, 2*pi, [1, 1, 0]);

gmsh.model.occ.addWedge(0, -4, 0, 0.4, 0.2, 0.4);
gmsh.model.occ.addWedge(1, -4, 0, 0.4, 0.2, 0.4, -1, 0., [0.2, 0, 1]);

gmsh.model.occ.synchronize();
gmsh.option.setNumber('Mesh.MeshSizeFromCurvature', 10);

gmsh.finalize();
