% Gmsh MATLAB tutorial 12 — Cross-patch meshing with compounds.

gmsh.initialize();

lc = 0.1;
gmsh.model.geo.addPoint(0,   0,    0,    lc, 1);
gmsh.model.geo.addPoint(1,   0,    0,    lc, 2);
gmsh.model.geo.addPoint(1,   1,    0.5,  lc, 3);
gmsh.model.geo.addPoint(0,   1,    0.4,  lc, 4);
gmsh.model.geo.addPoint(0.3, 0.2,  0,    lc, 5);
gmsh.model.geo.addPoint(0,   0.01, 0.01, lc, 6);
gmsh.model.geo.addPoint(0,   0.02, 0.02, lc, 7);
gmsh.model.geo.addPoint(1,   0.05, 0.02, lc, 8);
gmsh.model.geo.addPoint(1,   0.32, 0.02, lc, 9);

gmsh.model.geo.addLine(1, 2, 1);
gmsh.model.geo.addLine(2, 8, 2);
gmsh.model.geo.addLine(8, 9, 3);
gmsh.model.geo.addLine(9, 3, 4);
gmsh.model.geo.addLine(3, 4, 5);
gmsh.model.geo.addLine(4, 7, 6);
gmsh.model.geo.addLine(7, 6, 7);
gmsh.model.geo.addLine(6, 1, 8);
gmsh.model.geo.addSpline([7, 5, 9], 9);
gmsh.model.geo.addLine(6, 8, 10);

gmsh.model.geo.addCurveLoop([5, 6, 9, 4], 11);
gmsh.model.geo.addSurfaceFilling([11], 1);
gmsh.model.geo.addCurveLoop([-9, 3, 10, 7], 13);
gmsh.model.geo.addSurfaceFilling([13], 5);
gmsh.model.geo.addCurveLoop([-10, 2, 1, 8], 15);
gmsh.model.geo.addSurfaceFilling([15], 10);

gmsh.model.geo.synchronize();

gmsh.model.mesh.setCompound(1, [2, 3, 4]);
gmsh.model.mesh.setCompound(1, [6, 7, 8]);
gmsh.model.mesh.setCompound(2, [1, 5, 10]);

gmsh.model.mesh.generate(2);
gmsh.write("t12.msh");
gmsh.finalize();
