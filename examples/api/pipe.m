gmsh.initialize();

nturns = 2;  % tested ok up to 100

npts = 100 * nturns;
r    = 1.;
rd   = 0.1;
h    = 1. * nturns;

for i = 0:npts-1
    theta = i * 2*pi * nturns / npts;
    gmsh.model.occ.addPoint(r*cos(theta), r*sin(theta), i*h/npts, 0., i+1);
end

gmsh.model.occ.addSpline(1:npts-1, 1);
gmsh.model.occ.addWire([1], 1);

gmsh.model.occ.addDisk(1, 0, 0, rd, rd, 1);

gmsh.model.occ.addRectangle(1+2*rd, -rd, 0, 2*rd, 2*rd, 2, rd/5);
gmsh.model.occ.rotate([2, 1; 2, 2], 0, 0, 0, 1, 0, 0, pi/2);

gmsh.model.occ.addPipe([2, 1; 2, 2], 1, 'Frenet');

gmsh.model.occ.remove([2, 1; 2, 2; 1, 1]);
gmsh.model.occ.synchronize();

gmsh.option.setNumber('Mesh.MeshSizeMin', 0.1);
gmsh.option.setNumber('Mesh.MeshSizeMax', 0.1);
gmsh.option.setNumber('Geometry.NumSubEdges', npts);

gmsh.finalize();
