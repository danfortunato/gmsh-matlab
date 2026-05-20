gmsh.initialize();
gmsh.model.add("Tube boundary layer");

gmsh.option.setNumber("Mesh.MeshSizeMax", 0.1);
order2 = false;

% Fuse two cylinders and keep only the outer shell.
c1 = gmsh.model.occ.addCylinder(0, 0,  0, 5, 0, 0, 0.5);
c2 = gmsh.model.occ.addCylinder(2, 0, -2, 0, 0, 2, 0.3);
gmsh.model.occ.fuse([3, c1], [3, c2]);
gmsh.model.occ.remove(gmsh.model.occ.getEntities(3));
gmsh.model.occ.remove([2, 2; 2, 3; 2, 5]);
gmsh.model.occ.synchronize();

% Boundary-layer extrusion that returns only top entities.
gmsh.option.setNumber('Geometry.ExtrudeReturnLateralEntities', 0);
n = ones(1, 5);
d = logspace(-3, -1, 5);
e = gmsh.model.geo.extrudeBoundaryLayer(gmsh.model.getEntities(2), n, -d, true);

% "Top" surfaces created by the extrusion.
top_mask = e(:, 1) == 2;
top_ent  = e(top_mask, :);
top_surf = top_ent(:, 2).';

gmsh.model.geo.synchronize();
bnd_ent  = gmsh.model.getBoundary(top_ent);
bnd_curv = bnd_ent(:, 2).';

% Plane surfaces filling the holes.
loops = gmsh.model.geo.addCurveLoops(bnd_curv);
for l = loops
    top_surf(end+1) = gmsh.model.geo.addPlaneSurface([l]); %#ok<AGROW>
end

% Inner volume.
gmsh.model.geo.addVolume([gmsh.model.geo.addSurfaceLoop(top_surf)]);
gmsh.model.geo.synchronize();

gmsh.model.mesh.generate(3);

if order2
    gmsh.model.mesh.setOrder(2);
    gmsh.model.mesh.optimize('HighOrderFastCurving');
end

gmsh.finalize();
