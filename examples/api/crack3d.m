gmsh.initialize();

% Two adjacent boxes + a smaller surface on the interface.
v1 = gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
v2 = gmsh.model.occ.addBox(0, 0, -1, 1, 1, 1); %#ok<NASGU>
s1 = gmsh.model.occ.addRectangle(0.25, 0.25, 0, 0.5, 0.5);

% Fragment the model to make the geometry conformal.
[~, out_map] = gmsh.model.occ.fragment([2, s1], [3, v1; 3, v2]);
gmsh.model.occ.synchronize();

% Physical group on the small surface (Crack uses physical groups as input).
phys = gmsh.model.addPhysicalGroup(2, out_map{1}(1, 2));

gmsh.model.mesh.generate(3);

% "Crack" the mesh by duplicating elements and nodes on the small surface.
gmsh.plugin.setNumber("Crack", "Dimension", 2);
gmsh.plugin.setNumber("Crack", "PhysicalGroup", phys);
gmsh.plugin.setNumber("Crack", "DebugView", 1);
gmsh.plugin.run("Crack");

% Save all elements, even those not in any physical group.
gmsh.option.setNumber("Mesh.SaveAll", 1);
gmsh.write("crack.msh");

gmsh.finalize();
