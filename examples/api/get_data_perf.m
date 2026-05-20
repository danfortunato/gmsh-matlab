gmsh.initialize();

gmsh.model.add("square");
gmsh.model.occ.addRectangle(0, 0, 0, 1, 1, 100);
gmsh.model.occ.synchronize();
gmsh.model.mesh.setTransfiniteSurface(100);
gmsh.model.mesh.generate(2);

gmsh.plugin.setNumber("NewView", "Value", 1.234);
t = gmsh.plugin.run("NewView");

disp("before get");
[~, ~, ~, ~, ~] = gmsh.view.getModelData(t, 0);
disp("after get");

disp("before getHomogeneous");
[~, ~, ~, ~, ~] = gmsh.view.getHomogeneousModelData(t, 0);
disp("after getHomogeneous");

gmsh.finalize();
