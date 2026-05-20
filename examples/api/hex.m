gmsh.initialize();
gmsh.option.setNumber("Mesh.MshFileVersion", 2.2);  % save in old MSH format
N = 4;
Rec2d = true;  % tris or quads
Rec3d = true;  % tets, prisms or hexas
p = gmsh.model.geo.addPoint(0, 0, 0);
l = gmsh.model.geo.extrude([0, p], 1, 0, 0, [N], [1]);
s = gmsh.model.geo.extrude(l(2, :), 0, 1, 0, [N], [1], Rec2d);
v = gmsh.model.geo.extrude(s(2, :), 0, 0, 1, [N], [1], Rec3d);
gmsh.model.geo.synchronize();
gmsh.model.addPhysicalGroup(3, v(2, 2));
gmsh.model.mesh.generate(3);
gmsh.write("mesh.msh");
gmsh.finalize();
