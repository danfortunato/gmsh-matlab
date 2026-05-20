% Shows how to identify parts after boolean fragments.
gmsh.initialize();
gmsh.model.occ.addRectangle(-0.6, -0.6, 0, 2.2, 2.2, 1);
N = 20;
rng(0);  % seed differs from Python; the topology is similar in spirit.
for i = 2:N+1
    h = 0.05 + rand * 0.5;
    w = 0.01 + rand * 0.1;
    x = rand;
    y = rand;
    alpha = rand * 2 * pi;
    gmsh.model.occ.addRectangle(x, y, 0, w, h, i);
    gmsh.model.occ.rotate([2, i], x, y, 0, 0, 0, 1, alpha);
end

rin = [2*ones(N+1, 1), (1:N+1).'];
[rout, rinout] = gmsh.model.occ.fragment(rin, zeros(0, 2)); %#ok<ASGLU>

gmsh.model.occ.synchronize();

for k = 1:size(rin, 1)
    if rin(k, 2) ~= 1
        replacements = rinout{k};
        fprintf('fracture %d -> surfaces %s\n', ...
            rin(k, 2), mat2str(replacements(:, 2).'));
        gmsh.model.addPhysicalGroup(2, replacements(:, 2).', ...
            -1, sprintf('fracture%d', rin(k, 2)));
    end
end

gmsh.option.setNumber('Mesh.MeshSizeMin', 0.05);
gmsh.option.setNumber('Mesh.MeshSizeMax', 0.05);
gmsh.model.mesh.generate();

gmsh.finalize();
