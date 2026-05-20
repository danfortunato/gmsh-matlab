% Gmsh MATLAB tutorial 18 — Periodic meshes.

gmsh.initialize();
gmsh.model.add("t18");

gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1, 1);
gmsh.model.occ.synchronize();

gmsh.model.mesh.setSize(gmsh.model.getEntities(0), 0.1);
gmsh.model.mesh.setSize([0 1], 0.02);

translation = [1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
gmsh.model.mesh.setPeriodic(2, [2], [1], translation);
gmsh.model.mesh.setPeriodic(2, [6], [5], [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1]);
gmsh.model.mesh.setPeriodic(2, [4], [3], [1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1]);

gmsh.model.occ.addBox(2, 0, 0, 1, 1, 1, 10);
x = 2 - 0.3;
y = 0;
z = 0;
gmsh.model.occ.addSphere(x,   y,   z,   0.35, 11, -pi/2, pi/2, 2*pi);
gmsh.model.occ.addSphere(x+1, y,   z,   0.35, 12, -pi/2, pi/2, 2*pi);
gmsh.model.occ.addSphere(x,   y+1, z,   0.35, 13, -pi/2, pi/2, 2*pi);
gmsh.model.occ.addSphere(x,   y,   z+1, 0.35, 14, -pi/2, pi/2, 2*pi);
gmsh.model.occ.addSphere(x+1, y+1, z,   0.35, 15, -pi/2, pi/2, 2*pi);
gmsh.model.occ.addSphere(x,   y+1, z+1, 0.35, 16, -pi/2, pi/2, 2*pi);
gmsh.model.occ.addSphere(x+1, y,   z+1, 0.35, 17, -pi/2, pi/2, 2*pi);
gmsh.model.occ.addSphere(x+1, y+1, z+1, 0.35, 18, -pi/2, pi/2, 2*pi);

spheres = [3*ones(8,1), (11:18).'];
[out, ~] = gmsh.model.occ.fragment([3 10], spheres, -1, true, true);
gmsh.model.occ.synchronize();

gmsh.option.setNumber("Geometry.OCCBoundsUseStl", 1);

eps_ = 1e-3;
vin = gmsh.model.getEntitiesInBoundingBox(2-eps_, -eps_, -eps_, ...
                                           2+1+eps_, 1+eps_, 1+eps_, 3);
% Remove rows of `out` that appear in `vin`.
keep = true(size(out, 1), 1);
for k = 1:size(vin, 1)
    match = all(out == vin(k,:), 2);
    keep = keep & ~match;
end
out_to_remove = out(keep, :);
gmsh.model.removeEntities(out_to_remove, true);

p = gmsh.model.getBoundary(vin, false, false, true);
gmsh.model.mesh.setSize(p, 0.1);
p = gmsh.model.getEntitiesInBoundingBox(2-eps_, -eps_, -eps_, 2+eps_, eps_, eps_, 0);
gmsh.model.mesh.setSize(p, 0.001);

sxmin = gmsh.model.getEntitiesInBoundingBox(2-eps_, -eps_, -eps_, ...
                                             2+eps_, 1+eps_, 1+eps_, 2);

for i = 1:size(sxmin, 1)
    [xmin, ymin, zmin, xmax, ymax, zmax] = gmsh.model.getBoundingBox(sxmin(i,1), sxmin(i,2));
    sxmax = gmsh.model.getEntitiesInBoundingBox(xmin-eps_+1, ymin-eps_, zmin-eps_, ...
                                                 xmax+eps_+1, ymax+eps_, zmax+eps_, 2);
    for j = 1:size(sxmax, 1)
        [xmin2, ymin2, zmin2, xmax2, ymax2, zmax2] = gmsh.model.getBoundingBox(sxmax(j,1), sxmax(j,2));
        xmin2 = xmin2 - 1;
        xmax2 = xmax2 - 1;
        if abs(xmin2-xmin) < eps_ && abs(xmax2-xmax) < eps_ && ...
           abs(ymin2-ymin) < eps_ && abs(ymax2-ymax) < eps_ && ...
           abs(zmin2-zmin) < eps_ && abs(zmax2-zmax) < eps_
            gmsh.model.mesh.setPeriodic(2, [sxmax(j,2)], [sxmin(i,2)], translation);
        end
    end
end

gmsh.model.mesh.generate(3);
gmsh.write("t18.msh");
gmsh.finalize();
