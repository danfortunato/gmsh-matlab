gmsh.initialize();

N = 2500;

tic_t = gmsh.logger.getWallTime();

[coords, nodes, tris] = create_mesh(N);
toc_t = gmsh.logger.getWallTime();
fprintf('==> created nodes and connectivities in %g seconds\n', toc_t - tic_t);

tic_t = gmsh.logger.getWallTime();
gmsh.model.addDiscreteEntity(2);
toc_t = gmsh.logger.getWallTime();
fprintf('==> created surface in %g seconds\n', toc_t - tic_t);

tic_t = gmsh.logger.getWallTime();
gmsh.model.mesh.addNodes(2, 1, nodes, coords);
toc_t = gmsh.logger.getWallTime();
fprintf('==> imported nodes in %g seconds\n', toc_t - tic_t);

tic_t = gmsh.logger.getWallTime();
gmsh.model.mesh.addElementsByType(1, 2, [], tris);
toc_t = gmsh.logger.getWallTime();
fprintf('==> imported elements in %g seconds\n', toc_t - tic_t);

tic_t = gmsh.logger.getWallTime();
gmsh.option.setNumber("Mesh.Binary", 1);
gmsh.write("import_perf_py.msh");
toc_t = gmsh.logger.getWallTime();
fprintf('==> wrote to disk in %g seconds\n', toc_t - tic_t);

tic_t = gmsh.logger.getWallTime();
gmsh.merge("import_perf_py.msh");
toc_t = gmsh.logger.getWallTime();
fprintf('==> read from disk in %g seconds\n', toc_t - tic_t);

gmsh.finalize();


function [coords, nodes, tris] = create_mesh(N)
    % Vectorised equivalent of the numpy fast path in import_perf.py.
    l = linspace(0, 1, N + 1);
    [X, Y] = meshgrid(l, l);
    Z = 0.05 * sin(10 * (X + Y));
    % coords are stored per-node as (x, y, z), flattened row-major (i, j).
    coords = reshape(cat(3, X.', Y.', Z.'), 1, []);
    nodes = uint64(reshape(1:(N+1)^2, N+1, N+1));   % (i, j) -> tag
    % Two triangles per (i, j) cell where i, j range over [0..N-1].
    a = nodes(1:N, 1:N);     % (i,   j)
    b = nodes(2:N+1, 1:N);   % (i+1, j)
    c = nodes(1:N, 2:N+1);   % (i,   j+1)
    d = nodes(2:N+1, 2:N+1); % (i+1, j+1)
    tris = reshape(cat(3, a, b, c, b, d, c), 1, []);
    nodes = reshape(nodes, 1, []);
end
