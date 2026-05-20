% Number of points to tetrahedralize.
N = 100;

gmsh.initialize();
gmsh.option.setNumber('Mesh.Algorithm3D', 10);  % new algo

rng(0);
points = randn(1, 3 * N);
[tets, ~] = gmsh.algorithm.tetrahedralize(points);

vol = gmsh.model.addDiscreteEntity(3);
gmsh.model.mesh.addNodes(3, vol, 1:N, points);
gmsh.model.mesh.addElementsByType(vol, 4, [], tets);

gmsh.finalize();
