% ------------------------------------------------------------------------------
%
%  Gmsh MATLAB tutorial 1
%
%  Geometry basics, elementary entities, physical groups
%
% ------------------------------------------------------------------------------
%
% Port of gmsh/tutorials/python/t1.py. Add the gmsh_matlab folder to your path
% (`addpath('<repo>/gmsh_matlab')`) and run this script.

% Before using any functions in the API, Gmsh must be initialized:
gmsh.initialize();

% Add a new model named "t1":
gmsh.model.add("t1");

lc = 1e-2;
gmsh.model.geo.addPoint(0,   0,   0, lc, 1);
gmsh.model.geo.addPoint(0.1, 0,   0, lc, 2);
gmsh.model.geo.addPoint(0.1, 0.3, 0, lc, 3);
p4 = gmsh.model.geo.addPoint(0, 0.3, 0, lc);  %#ok<NASGU>

gmsh.model.geo.addLine(1, 2, 1);
gmsh.model.geo.addLine(3, 2, 2);
gmsh.model.geo.addLine(3, 4, 3);
gmsh.model.geo.addLine(4, 1, 4);

gmsh.model.geo.addCurveLoop([4, 1, -2, 3], 1);
gmsh.model.geo.addPlaneSurface([1], 1);

gmsh.model.geo.synchronize();

gmsh.model.addPhysicalGroup(1, [1, 2, 4], 5);
gmsh.model.addPhysicalGroup(2, [1], -1, "My surface");

gmsh.model.mesh.generate(2);

gmsh.write("t1.msh");

% Uncomment to launch the FLTK GUI:
% gmsh.fltk.run();

gmsh.finalize();
