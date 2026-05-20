gmsh.initialize();

gmsh.model.add("2d surface mesh with purely discrete boundary");

% Discrete curve with N nodes and N line elements.
gmsh.model.addDiscreteEntity(1, 100);
N = 50;
dt = 2*pi/N;
i = 0:N-1;
pts = [cos(i*dt); sin(i*dt); zeros(1,N)];
flat_pts = pts(:).';
gmsh.model.mesh.addNodes(1, 100, 1:N, flat_pts);

% Line element connectivity: (1,2),(2,3),...,(N,1).
n = reshape([1:N; circshift(1:N, -1)], 1, []);
gmsh.model.mesh.addElements(1, 100, [1], {1:N}, {n});

gmsh.model.geo.addCurveLoop([100], 101);
gmsh.model.geo.addPlaneSurface([101], 102);
gmsh.model.geo.synchronize();

gmsh.model.mesh.generate(2);
gmsh.finalize();
