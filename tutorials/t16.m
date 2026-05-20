% Gmsh MATLAB tutorial 16 — CSG with OpenCASCADE geometry kernel.

gmsh.initialize();
gmsh.model.add("t16");

gmsh.logger.start();

gmsh.model.occ.addBox(0, 0, 0, 1,   1,   1,   1);
gmsh.model.occ.addBox(0, 0, 0, 0.5, 0.5, 0.5, 2);
gmsh.model.occ.cut([3 1], [3 2], 3, true, true);

x = 0; y = 0.75; z = 0; r = 0.09;
holes = zeros(0, 2, 'int32');
for t = 1:5
    x = x + 0.166;
    z = z + 0.166;
    gmsh.model.occ.addSphere(x, y, z, r, 3 + t, -pi/2, pi/2, 2*pi);
    holes(end+1, :) = [3, 3 + t];  %#ok<AGROW>
end

[ov, ~] = gmsh.model.occ.fragment([3 3], holes, -1, true, true);

gmsh.model.occ.synchronize();

for i = 1:5
    gmsh.model.addPhysicalGroup(3, [3 + i], i, '');
end
gmsh.model.addPhysicalGroup(3, [ov(1,2)], 10, '');

bnd = gmsh.model.getBoundary(gmsh.model.getEntities(3), true, false, false);
[closest, ~] = gmsh.model.occ.getClosestEntities(1, 1, 0.5, bnd, 2);
gmsh.model.addPhysicalGroup(2, [closest(1,2), closest(2,2)], 100, "Top & right surfaces");

lcar1 = 0.1;
lcar2 = 5e-4;
lcar3 = 0.055;
gmsh.model.mesh.setSize(gmsh.model.getEntities(0), lcar1);
gmsh.model.mesh.setSize(gmsh.model.getBoundary(holes, false, false, true), lcar3);

eps_ = 1e-3;
ov = gmsh.model.getEntitiesInBoundingBox(0.5-eps_, 0.5-eps_, 0.5-eps_, ...
                                          0.5+eps_, 0.5+eps_, 0.5+eps_, 0);
gmsh.model.mesh.setSize(ov, lcar2);

gmsh.model.mesh.generate(3);
gmsh.write("t16.msh");

log = gmsh.logger.get();
fprintf('Logger has recorded %d lines\n', numel(log));
gmsh.logger.stop();

gmsh.finalize();
