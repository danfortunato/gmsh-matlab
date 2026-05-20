% Gmsh MATLAB tutorial 20 — STEP import and manipulation, geometry partitioning.

gmsh.initialize();
gmsh.model.add("t20");

v = gmsh.model.occ.importShapes("t20_data.step", true, '');

[xmin, ymin, zmin, xmax, ymax, zmax] = gmsh.model.occ.getBoundingBox(v(1,1), v(1,2));

N = 5;
direction = 'X';
surf = false;

dx = xmax - xmin;
dy = ymax - ymin;
dz = zmax - zmin;
if direction == 'X', L = dz; else, L = dx; end
if direction == 'Y', H = dz; else, H = dy; end

s = zeros(0, 2, 'int32');
firstTag = gmsh.model.occ.addRectangle(xmin, ymin, zmin, L, H, -1, 0);
s(end+1, :) = [2, firstTag];  %#ok<AGROW>
if direction == 'X'
    gmsh.model.occ.rotate([s(1,:)], xmin, ymin, zmin, 0, 1, 0, -pi/2);
elseif direction == 'Y'
    gmsh.model.occ.rotate([s(1,:)], xmin, ymin, zmin, 1, 0, 0, pi/2);
end
if direction == 'X', tx = dx / N; else, tx = 0; end
if direction == 'Y', ty = dy / N; else, ty = 0; end
if direction == 'Z', tz = dz / N; else, tz = 0; end
gmsh.model.occ.translate([s(1,:)], tx, ty, tz);

for i = 1:(N-2)
    cp = gmsh.model.occ.copy([s(1,:)]);
    gmsh.model.occ.translate(cp, i * tx, i * ty, i * tz);
    s(end+1, :) = cp;  %#ok<AGROW>
end

gmsh.model.occ.fragment(v, s, -1, true, true);

gmsh.model.occ.remove(gmsh.model.occ.getEntities(2), true);
gmsh.model.occ.synchronize();

if surf
    eps_ = 1e-4;
    sf = zeros(0, 2, 'int32');
    for i = 1:(N-1)
        if direction == 'X', xx = xmin; else, xx = xmax; end
        if direction == 'Y', yy = ymin; else, yy = ymax; end
        if direction == 'Z', zz = zmin; else, zz = zmax; end
        e = gmsh.model.getEntitiesInBoundingBox( ...
            xmin - eps_ + i*tx, ymin - eps_ + i*ty, zmin - eps_ + i*tz, ...
            xx + eps_ + i*tx,    yy + eps_ + i*ty,   zz + eps_ + i*tz, 2);
        sf = [sf; e]; %#ok<AGROW>
    end
    dels = gmsh.model.getEntities(2);
    keep = true(size(dels, 1), 1);
    for k = 1:size(sf,1)
        keep = keep & ~all(dels == sf(k,:), 2);
    end
    dels = dels(keep, :);
    gmsh.model.removeEntities(gmsh.model.getEntities(3), false);
    gmsh.model.removeEntities(dels, false);
    gmsh.model.removeEntities(gmsh.model.getEntities(1), false);
    gmsh.model.removeEntities(gmsh.model.getEntities(0), false);
end

gmsh.option.setNumber("Mesh.MeshSizeMin", 3);
gmsh.option.setNumber("Mesh.MeshSizeMax", 3);
gmsh.model.mesh.generate(3);
gmsh.write("t20.msh");
gmsh.finalize();
