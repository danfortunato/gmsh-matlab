gmsh.initialize();

here = fileparts(mfilename('fullpath'));
gmsh.merge(fullfile(here, 'surface1.stl'));
gmsh.merge(fullfile(here, 'surface2.stl'));

gmsh.option.setNumber('Geometry.Tolerance', 1e-4);
gmsh.model.mesh.removeDuplicateNodes();

gmsh.model.mesh.classifySurfaces(pi / 2);

gmsh.model.mesh.createGeometry();

s = gmsh.model.getEntities(2);
l = gmsh.model.geo.addSurfaceLoop(s(:, 2).');
gmsh.model.geo.addVolume([l]);
gmsh.model.geo.synchronize();

gmsh.option.setNumber("Mesh.Algorithm", 6);
gmsh.option.setNumber("Mesh.MeshSizeMin", 0.4);
gmsh.option.setNumber("Mesh.MeshSizeMax", 0.4);
gmsh.model.mesh.generate(3);

gmsh.finalize();
