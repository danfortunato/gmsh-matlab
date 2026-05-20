% ------------------------------------------------------------------------------
%
%  Gmsh MATLAB tutorial 11
%
%  Unstructured quadrangular meshes
%
% ------------------------------------------------------------------------------

gmsh.initialize();

gmsh.model.add("t11");

% We have seen in tutorials `t3.py' and `t6.py' that extruded and transfinite
% meshes can be "recombined" into quads, prisms or hexahedra. Unstructured
% meshes can be recombined in the same way.

p1 = gmsh.model.geo.addPoint(-1.25, -0.5,  0);
p2 = gmsh.model.geo.addPoint( 1.25, -0.5,  0);
p3 = gmsh.model.geo.addPoint( 1.25,  1.25, 0);
p4 = gmsh.model.geo.addPoint(-1.25,  1.25, 0);

l1 = gmsh.model.geo.addLine(p1, p2);
l2 = gmsh.model.geo.addLine(p2, p3);
l3 = gmsh.model.geo.addLine(p3, p4);
l4 = gmsh.model.geo.addLine(p4, p1);

cl = gmsh.model.geo.addCurveLoop([l1, l2, l3, l4]);
pl = gmsh.model.geo.addPlaneSurface([cl]);

gmsh.model.geo.synchronize();

gmsh.model.mesh.field.add("MathEval", 1);
gmsh.model.mesh.field.setString(1, "F", ...
    "0.01*(1.0+30.*(y-x*x)*(y-x*x) + (1-x)*(1-x))");
gmsh.model.mesh.field.setAsBackgroundMesh(1);

% Recombine triangles into quadrangles.
gmsh.model.mesh.setRecombine(2, pl);

gmsh.model.mesh.generate(2);

gmsh.finalize();
