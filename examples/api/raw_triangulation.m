% Number of points to triangulate.
N = 100;

gmsh.initialize();

rng(0);  % reproducibility
points = randn(1, 2 * N);
tris = gmsh.algorithm.triangulate(points);

% Build a discrete surface to visualise the triangulation.
surf = gmsh.model.addDiscreteEntity(2);
xy = reshape(points, 2, N).';   % Nx2
xyz = reshape([xy, zeros(N, 1)].', 1, []);  % flat row of 3*N values
gmsh.model.mesh.addNodes(2, surf, 1:N, xyz);
gmsh.model.mesh.addElementsByType(surf, 2, [], tris);

gmsh.finalize();
