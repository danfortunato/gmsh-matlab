gmsh.initialize();

s = gmsh.model.occ.addRectangle(0, 0, 0, 3, 2);
gmsh.model.occ.synchronize();

m = gmsh.model.occ.getMass(2, s);
fprintf('mass from occ =  %g\n', m);

p = gmsh.model.addPhysicalGroup(2, [s]);
gmsh.model.mesh.generate(2);

gmsh.plugin.setNumber("MeshVolume", "Dimension", 2);
gmsh.plugin.setNumber("MeshVolume", "PhysicalGroup", p);
t = gmsh.plugin.run("MeshVolume");

[~, ~, data] = gmsh.view.getListData(t);
fprintf('volume from mesh =  %g\n', data{1}(4));

gmsh.finalize();
