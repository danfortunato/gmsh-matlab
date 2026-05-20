gmsh.initialize();

v0 = gmsh.model.occ.addSphere(0, 0, 0, 2);

% Wires in the parametric plane of the spherical surface [-pi,pi] x [-pi/2,pi/2].
c1 = gmsh.model.occ.addCircle(0, 0, 0, 0.4);
w1 = gmsh.model.occ.addWire([c1]);

c2 = gmsh.model.occ.addCircle(0, 0, 0, 0.2);
w2 = gmsh.model.occ.addWire([c2]);

s3 = gmsh.model.occ.addRectangle(0, 0.5, 0, 5, 0.5);
gmsh.model.occ.synchronize();
b3 = gmsh.model.getBoundary([2, s3]);
w3 = gmsh.model.occ.addWire(b3(:, 2).');

% Spherical surface.
bnd = gmsh.model.getBoundary([3, v0]);
s0 = bnd(1, 2);

% Two trimmed surfaces from the spherical surface.
gmsh.model.occ.addTrimmedSurface(s0, [w1, w2]);
gmsh.model.occ.addTrimmedSurface(s0, [w3]);

% Remove the sphere.
gmsh.model.occ.remove([3, v0], true);
gmsh.model.occ.synchronize();

gmsh.finalize();
