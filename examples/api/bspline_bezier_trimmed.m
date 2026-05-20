gmsh.initialize();

gmsh.model.occ.addPoint(0.1, 0, 0.75);
gmsh.model.occ.addPoint(1,   0, 0.65);
gmsh.model.occ.addPoint(2,   0, 0.5);
gmsh.model.occ.addPoint(3,   0, 0.2);
gmsh.model.occ.addPoint(4,   0, 0);

gmsh.model.occ.addPoint(0.1, 1, 0.1);
gmsh.model.occ.addPoint(1,   1, 0);
gmsh.model.occ.addPoint(2,   1, 0);
gmsh.model.occ.addPoint(3,   1, 0);
gmsh.model.occ.addPoint(4,   1, 0);

gmsh.model.occ.addPoint(0,   2, 0.2);
gmsh.model.occ.addPoint(1,   2, 0);
gmsh.model.occ.addPoint(2,   2, 0.1);
gmsh.model.occ.addPoint(3,   2, 0);
gmsh.model.occ.addPoint(4,   2, 0);

gmsh.model.occ.addPoint(0,   3, 0.1);
gmsh.model.occ.addPoint(1,   3, 0);
gmsh.model.occ.addPoint(2,   3, 0);
gmsh.model.occ.addPoint(3,   3, 0);
gmsh.model.occ.addPoint(4,   3, 0);

c  = gmsh.model.occ.addCircle(0.5, 0.5, 0, 0.4);
w  = gmsh.model.occ.addWire([c]);

c2 = gmsh.model.occ.addCircle(0.5, 0.5, 0, 0.2);
w2 = gmsh.model.occ.addWire([c2]);

use3d = false;
gmsh.model.occ.addBSplineSurface(1:20, 5, -1, 3, 3, [], [], [], [], [], [w, w2], use3d);

gmsh.model.occ.synchronize();
gmsh.finalize();
