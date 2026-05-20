% Gmsh MATLAB tutorial 19 — Thrusections, fillets, pipes, mesh size from curvature.

gmsh.initialize();
gmsh.model.add("t19");

gmsh.model.occ.addCircle(0,    0,    0, 0.5, 1, 0, 2*pi, [], []);
gmsh.model.occ.addCurveLoop([1], 1);
gmsh.model.occ.addCircle(0.1,  0.05, 1, 0.1, 2, 0, 2*pi, [], []);
gmsh.model.occ.addCurveLoop([2], 2);
gmsh.model.occ.addCircle(-0.1, -0.1, 2, 0.3, 3, 0, 2*pi, [], []);
gmsh.model.occ.addCurveLoop([3], 3);
gmsh.model.occ.addThruSections([1, 2, 3], 1, true, false, -1, '', '', false);
gmsh.model.occ.synchronize();

gmsh.model.occ.addCircle(2+0,    0,    0, 0.5, 11, 0, 2*pi, [], []);
gmsh.model.occ.addCurveLoop([11], 11);
gmsh.model.occ.addCircle(2+0.1,  0.05, 1, 0.1, 12, 0, 2*pi, [], []);
gmsh.model.occ.addCurveLoop([12], 12);
gmsh.model.occ.addCircle(2-0.1, -0.1, 2, 0.3, 13, 0, 2*pi, [], []);
gmsh.model.occ.addCurveLoop([13], 13);
gmsh.model.occ.addThruSections([11, 12, 13], 11, true, true, -1, '', '', false);
gmsh.model.occ.synchronize();

out = gmsh.model.occ.copy([3 1]);
gmsh.model.occ.translate(out, 4, 0, 0);
gmsh.model.occ.synchronize();
e = gmsh.model.getBoundary(gmsh.model.getBoundary(out, true, false, false), false, false, false);
edge_tags = abs(e(:,2));
gmsh.model.occ.fillet([out(1,2)], edge_tags, [0.1], true);
gmsh.model.occ.synchronize();

nturns = 1.0;
npts = 20;
r = 1.0;
h = 1.0 * nturns;
p = zeros(1, npts);
for i = 0:(npts-1)
    theta = i * 2 * pi * nturns / npts;
    gmsh.model.occ.addPoint(r*cos(theta), r*sin(theta), i*h/npts, 1, 1000+i);
    p(i+1) = 1000 + i;
end
gmsh.model.occ.addSpline(p, 1000);
gmsh.model.occ.addWire([1000], 1000, false);

gmsh.model.occ.addDisk(1, 0, 0, 0.2, 0.2, 1000, [], []);
gmsh.model.occ.rotate([2 1000], 0, 0, 0, 1, 0, 0, pi/2);

gmsh.model.occ.addPipe([2 1000], 1000, 'DiscreteTrihedron');

gmsh.model.occ.remove([2 1000], false);
gmsh.option.setNumber("Geometry.NumSubEdges", 1000);

gmsh.model.occ.synchronize();

gmsh.option.setNumber("Mesh.MeshSizeFromCurvature", 20);
gmsh.option.setNumber("Mesh.MeshSizeMin", 0.001);
gmsh.option.setNumber("Mesh.MeshSizeMax", 0.3);

gmsh.model.mesh.generate(3);
gmsh.write("t19.msh");
gmsh.finalize();
