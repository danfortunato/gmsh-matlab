gmsh.initialize();

gmsh.model.add("terrain");

N = 100;
ps = zeros(1, N*N);
idx = 1;
for i = 0:N-1
    for j = 0:N-1
        ps(idx) = gmsh.model.occ.addPoint( ...
            i/(N-1), j/(N-1), 0.05 * sin(10*(i+j)/(N-1)));
        idx = idx + 1;
    end
end
s = gmsh.model.occ.addBSplineSurface(ps, N);

% A box for fragmentation.
v = gmsh.model.occ.addBox(0, 0, -0.5, 1, 1, 1);

gmsh.model.occ.fragment([2, s], [3, v]);
gmsh.model.occ.synchronize();

% Define an ONELAB parameter for interactive selection (the FLTK loop in the
% Python script is GUI-only; we mirror the non-interactive branch).
gmsh.onelab.set(sprintf(['[ ' ...
    '  { "type":"number", "name":"Parameters/Full-hex mesh?", ' ...
    '    "values":[0], "choices":[0, 1] } ' ...
    ']']));

if gmsh.onelab.getNumber('Parameters/Full-hex mesh?') == 1
    NN = 30;
    curves = gmsh.model.getEntities(1);
    for k = 1:size(curves, 1)
        gmsh.model.mesh.setTransfiniteCurve(curves(k, 2), NN);
        surfs = gmsh.model.getEntities(2);
        for j = 1:size(surfs, 1)
            gmsh.model.mesh.setTransfiniteSurface(surfs(j, 2));
            gmsh.model.mesh.setRecombine(surfs(j, 1), surfs(j, 2));
            gmsh.model.mesh.setSmoothing(surfs(j, 1), surfs(j, 2), 100);
        end
    end
    gmsh.model.mesh.setTransfiniteVolume(1);
    gmsh.model.mesh.setTransfiniteVolume(2);
else
    gmsh.model.mesh.removeConstraints();
    gmsh.option.setNumber('Mesh.MeshSizeMin', 0.05);
    gmsh.option.setNumber('Mesh.MeshSizeMax', 0.05);
end

gmsh.finalize();
