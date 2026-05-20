% Gmsh MATLAB tutorial 6 — Transfinite meshes, deleting entities.

gmsh.initialize();
gmsh.model.add("t6");

lc = 1e-2;
gmsh.model.geo.addPoint(0,   0,   0, lc, 1);
gmsh.model.geo.addPoint(0.1, 0,   0, lc, 2);
gmsh.model.geo.addPoint(0.1, 0.3, 0, lc, 3);
gmsh.model.geo.addPoint(0,   0.3, 0, lc, 4);
gmsh.model.geo.addLine(1, 2, 1);
gmsh.model.geo.addLine(3, 2, 2);
gmsh.model.geo.addLine(3, 4, 3);
gmsh.model.geo.addLine(4, 1, 4);
gmsh.model.geo.addCurveLoop([4, 1, -2, 3], 1);
gmsh.model.geo.addPlaneSurface([1], 1);

gmsh.model.geo.remove([2 1; 1 4], false);

p1 = gmsh.model.geo.addPoint(-0.05, 0.05, 0, lc);
p2 = gmsh.model.geo.addPoint(-0.05, 0.1,  0, lc);
l1 = gmsh.model.geo.addLine(1,  p1);
l2 = gmsh.model.geo.addLine(p1, p2);
l3 = gmsh.model.geo.addLine(p2, 4);

gmsh.model.geo.addCurveLoop([2, -1, l1, l2, l3, -3], 2);
gmsh.model.geo.addPlaneSurface([-2], 1);

gmsh.model.geo.mesh.setTransfiniteCurve(2, 20, "Progression", 1);
gmsh.model.geo.mesh.setTransfiniteCurve(l1, 6, "Progression", 1);
gmsh.model.geo.mesh.setTransfiniteCurve(l2, 6, "Progression", 1);
gmsh.model.geo.mesh.setTransfiniteCurve(l3, 10, "Progression", 1);
gmsh.model.geo.mesh.setTransfiniteCurve(1, 30, "Progression", -1.2);
gmsh.model.geo.mesh.setTransfiniteCurve(3, 30, "Progression", 1.2);

gmsh.model.geo.mesh.setTransfiniteSurface(1, "Left", [1, 2, 3, 4]);
gmsh.model.geo.mesh.setRecombine(2, 1, 45);

gmsh.model.geo.addPoint(0.2,  0.2, 0, 1.0, 7);
gmsh.model.geo.addPoint(0.2,  0.1, 0, 1.0, 8);
gmsh.model.geo.addPoint(0.25, 0.2, 0, 1.0, 9);
gmsh.model.geo.addPoint(0.3,  0.1, 0, 1.0, 10);
gmsh.model.geo.addLine(8,  10, 10);
gmsh.model.geo.addLine(10, 9,  11);
gmsh.model.geo.addLine(9,  7,  12);
gmsh.model.geo.addLine(7,  8,  13);
gmsh.model.geo.addCurveLoop([13, 10, 11, 12], 14);
gmsh.model.geo.addPlaneSurface([14], 15);
for i = 10:13
    gmsh.model.geo.mesh.setTransfiniteCurve(i, 10, "Progression", 1);
end
gmsh.model.geo.mesh.setTransfiniteSurface(15, "Left", []);

gmsh.model.geo.synchronize();
gmsh.option.setNumber("Mesh.Smoothing", 100);

gmsh.model.mesh.generate(2);
gmsh.write("t6.msh");
gmsh.finalize();
