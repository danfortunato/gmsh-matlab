gmsh.initialize();

% Parametric surface: u, v, v^2.
g = gmsh.model.geo.addGeometry("ParametricSurface", [], {'u', 'v', 'v^2'});

p1 = gmsh.model.geo.addPointOnGeometry(g, 0, 0, 0, 0., 1);
p2 = gmsh.model.geo.addPointOnGeometry(g, 1, 0, 0, 0., 2);
p3 = gmsh.model.geo.addPointOnGeometry(g, 1, 1, 0, 0., 3);
p4 = gmsh.model.geo.addPointOnGeometry(g, 0, 1, 0, 0., 4);

l1 = gmsh.model.geo.addLine(p1, p2);
l2 = gmsh.model.geo.addLine(p2, p3);
l3 = gmsh.model.geo.addLine(p3, p4);
l4 = gmsh.model.geo.addLine(p4, p1);

cl = gmsh.model.geo.addCurveLoop([l1, l2, l3, l4]);
gmsh.model.geo.addPlaneSurface([cl]);
gmsh.model.geo.synchronize();

gmsh.finalize();
