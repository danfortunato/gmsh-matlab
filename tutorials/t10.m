% ------------------------------------------------------------------------------
%
%  Gmsh MATLAB tutorial 10
%
%  Mesh size fields
%
% ------------------------------------------------------------------------------
%
% Port of gmsh/tutorials/python/t10.py. Exercises gmsh.model.mesh.setSizeCallback
% (function-pointer callback), which the calllib-based binding cannot bridge.

gmsh.initialize();

gmsh.model.add("t10");

lc = 0.15;
gmsh.model.geo.addPoint(0.0, 0.0, 0, lc, 1);
gmsh.model.geo.addPoint(1,   0.0, 0, lc, 2);
gmsh.model.geo.addPoint(1,   1,   0, lc, 3);
gmsh.model.geo.addPoint(0,   1,   0, lc, 4);
gmsh.model.geo.addPoint(0.2, 0.5, 0, lc, 5);

gmsh.model.geo.addLine(1, 2, 1);
gmsh.model.geo.addLine(2, 3, 2);
gmsh.model.geo.addLine(3, 4, 3);
gmsh.model.geo.addLine(4, 1, 4);

gmsh.model.geo.addCurveLoop([1, 2, 3, 4], 5);
gmsh.model.geo.addPlaneSurface([5], 6);

gmsh.model.geo.synchronize();

gmsh.model.mesh.field.add("Distance", 1);
gmsh.model.mesh.field.setNumbers(1, "PointsList", [5]);
gmsh.model.mesh.field.setNumbers(1, "CurvesList", [2]);
gmsh.model.mesh.field.setNumber(1, "Sampling", 100);

gmsh.model.mesh.field.add("Threshold", 2);
gmsh.model.mesh.field.setNumber(2, "InField", 1);
gmsh.model.mesh.field.setNumber(2, "SizeMin", lc / 30);
gmsh.model.mesh.field.setNumber(2, "SizeMax", lc);
gmsh.model.mesh.field.setNumber(2, "DistMin", 0.15);
gmsh.model.mesh.field.setNumber(2, "DistMax", 0.5);

gmsh.model.mesh.field.add("MathEval", 3);
gmsh.model.mesh.field.setString(3, "F", ...
    "cos(4*3.14*x) * sin(4*3.14*y) / 10 + 0.101");

gmsh.model.mesh.field.add("Distance", 4);
gmsh.model.mesh.field.setNumbers(4, "PointsList", [1]);

gmsh.model.mesh.field.add("MathEval", 5);
gmsh.model.mesh.field.setString(5, "F", "F4^3 + " + string(lc / 100));

gmsh.model.mesh.field.add("Box", 6);
gmsh.model.mesh.field.setNumber(6, "VIn", lc / 15);
gmsh.model.mesh.field.setNumber(6, "VOut", lc);
gmsh.model.mesh.field.setNumber(6, "XMin", 0.3);
gmsh.model.mesh.field.setNumber(6, "XMax", 0.6);
gmsh.model.mesh.field.setNumber(6, "YMin", 0.3);
gmsh.model.mesh.field.setNumber(6, "YMax", 0.6);
gmsh.model.mesh.field.setNumber(6, "Thickness", 0.3);

gmsh.model.mesh.field.add("Min", 7);
gmsh.model.mesh.field.setNumbers(7, "FieldsList", [2, 3, 5, 6]);

gmsh.model.mesh.field.setAsBackgroundMesh(7);

% Global mesh-size callback: each query is multiplied by a function of x.
gmsh.model.mesh.setSizeCallback(@(dim, tag, x, y, z, lc_in) ...
    min(lc_in, 0.02 * x + 0.01));

gmsh.option.setNumber("Mesh.MeshSizeExtendFromBoundary", 0);
gmsh.option.setNumber("Mesh.MeshSizeFromPoints", 0);
gmsh.option.setNumber("Mesh.MeshSizeFromCurvature", 0);

gmsh.option.setNumber("Mesh.Algorithm", 5);

gmsh.model.mesh.generate(2);
gmsh.write("t10.msh");

gmsh.finalize();
