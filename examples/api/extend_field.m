gmsh.initialize();
b = gmsh.model.occ.addBox(0, 0, 0, 1, 1, 0.5);
s = gmsh.model.occ.addSphere(1, 1, 0.5, 0.4);
c = gmsh.model.occ.cut([3, b], [3, s]);
b1 = gmsh.model.occ.addBox(0.3, 0.3, 0.4, 0.1, 0.1, 0.1);
b2 = gmsh.model.occ.addBox(0.5, 0.5, 0.4, 0.1, 0.1, 0.1);
gmsh.model.occ.fragment([3, b1; 3, b2], c);
gmsh.model.occ.synchronize();

size_bulk  = 0.04;
size_small = 0.002;
dist_max   = 0.2;
power      = 2;

gmsh.model.mesh.setSize(gmsh.model.getEntities(0), size_bulk);
gmsh.model.mesh.setSize( ...
    gmsh.model.getBoundary([3, b1; 3, b2], true, true, true), size_small);

% "Extend" field.
f = gmsh.model.mesh.field.add("Extend");
surf_ents = gmsh.model.getEntities(2);
gmsh.model.mesh.field.setNumbers(f, "SurfacesList", surf_ents(:, 2).');
curve_ents = gmsh.model.getEntities(1);
gmsh.model.mesh.field.setNumbers(f, "CurvesList", curve_ents(:, 2).');
gmsh.model.mesh.field.setNumber(f, "DistMax", dist_max);
gmsh.model.mesh.field.setNumber(f, "SizeMax", size_bulk);
gmsh.model.mesh.field.setNumber(f, "Power", power);
gmsh.model.mesh.field.setAsBackgroundMesh(f);
gmsh.option.setNumber("Mesh.MeshSizeExtendFromBoundary", 0);

% New 3D algo.
gmsh.option.setNumber("Mesh.Algorithm3D", 10);

gmsh.finalize();
