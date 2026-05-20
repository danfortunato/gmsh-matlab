% Gmsh MATLAB tutorial 17 — Anisotropic background mesh.

gmsh.initialize();
gmsh.model.add("t17");

gmsh.model.occ.addRectangle(-2, -2, 0, 4, 4, -1, 0);
gmsh.model.occ.synchronize();

gmsh.merge("t17_bgmesh.pos");

bg_field = gmsh.model.mesh.field.add("PostView", -1);
gmsh.model.mesh.field.setNumber(bg_field, "ViewIndex", 0);
gmsh.model.mesh.field.setAsBackgroundMesh(bg_field);

gmsh.option.setNumber("Mesh.SmoothRatio", 3);
gmsh.option.setNumber("Mesh.AnisoMax", 1000);
gmsh.option.setNumber("Mesh.Algorithm", 7);

gmsh.model.mesh.generate(2);
gmsh.write("t17.msh");
gmsh.finalize();
