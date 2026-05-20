% Gmsh MATLAB tutorial 2 — Transformations, extruded geometries, volumes.

gmsh.initialize();
gmsh.model.add("t2");

% Copied from t1.m
lc = 1e-2;
gmsh.model.geo.addPoint(0,   0,   0, lc, 1);
gmsh.model.geo.addPoint(0.1, 0,   0, lc, 2);
gmsh.model.geo.addPoint(0.1, 0.3, 0, lc, 3);
gmsh.model.geo.addPoint(0,   0.3, 0, lc, 4);
gmsh.model.geo.addLine(1, 2, 1);
gmsh.model.geo.addLine(3, 2, 2);
gmsh.model.geo.addLine(3, 4, 3);
gmsh.model.geo.addLine(4, 1, 4);
gmsh.model.geo.addCurveLoop([4, 1, -2, 3], 1);
gmsh.model.geo.addPlaneSurface([1], 1);
gmsh.model.geo.synchronize();
gmsh.model.addPhysicalGroup(1, [1, 2, 4], 5);
gmsh.model.addPhysicalGroup(2, [1], -1, "My surface");

% Add new points and curves.
gmsh.model.geo.addPoint(0, 0.4, 0, lc, 5);
gmsh.model.geo.addLine(4, 5, 5);

% Translate point 5 (dim=0, tag=5) by (-0.02, 0, 0).
gmsh.model.geo.translate([0 5], -0.02, 0, 0);

% Rotate point 5 by -pi/4 around (0, 0.3, 0) along z.
gmsh.model.geo.rotate([0 5], 0, 0.3, 0, 0, 0, 1, -pi/4);

% Copy point 3 and translate the copy by 0.05 along y.
ov = gmsh.model.geo.copy([0 3]);
gmsh.model.geo.translate(ov, 0, 0.05, 0);

% Use the copy's new tag (ov is 1x2 [dim tag]).
gmsh.model.geo.addLine(3, ov(1,2), 7);
gmsh.model.geo.addLine(ov(1,2), 5, 8);
gmsh.model.geo.addCurveLoop([5, -8, -7, 3], 10);
gmsh.model.geo.addPlaneSurface([10], 11);

% Translate copies of surfaces 1 and 11 to the right.
ov = gmsh.model.geo.copy([2 1; 2 11]);
gmsh.model.geo.translate(ov, 0.12, 0, 0);

fprintf('New surfaces %d and %d\n', ov(1,2), ov(2,2));

gmsh.model.geo.addPoint(0,    0.3,  0.12, lc, 100);
gmsh.model.geo.addPoint(0.1,  0.3,  0.12, lc, 101);
gmsh.model.geo.addPoint(0.1,  0.35, 0.12, lc, 102);

gmsh.model.geo.synchronize();
xyz = gmsh.model.getValue(0, 5, []);
gmsh.model.geo.addPoint(xyz(1), xyz(2), 0.12, lc, 103);

gmsh.model.geo.addLine(4,   100, 110);
gmsh.model.geo.addLine(3,   101, 111);
gmsh.model.geo.addLine(6,   102, 112);
gmsh.model.geo.addLine(5,   103, 113);
gmsh.model.geo.addLine(103, 100, 114);
gmsh.model.geo.addLine(100, 101, 115);
gmsh.model.geo.addLine(101, 102, 116);
gmsh.model.geo.addLine(102, 103, 117);

gmsh.model.geo.addCurveLoop([115, -111, 3, 110], 118);
gmsh.model.geo.addPlaneSurface([118], 119);
gmsh.model.geo.addCurveLoop([111, 116, -112, -7], 120);
gmsh.model.geo.addPlaneSurface([120], 121);
gmsh.model.geo.addCurveLoop([112, 117, -113, -8], 122);
gmsh.model.geo.addPlaneSurface([122], 123);
gmsh.model.geo.addCurveLoop([114, -110, 5, 113], 124);
gmsh.model.geo.addPlaneSurface([124], 125);
gmsh.model.geo.addCurveLoop([115, 116, 117, 114], 126);
gmsh.model.geo.addPlaneSurface([126], 127);

gmsh.model.geo.addSurfaceLoop([127, 119, 121, 123, 125, 11], 128);
gmsh.model.geo.addVolume([128], 129);

% Extrude surface 11 (now copy ov(2,:)) along z by 0.12 to make another volume.
ov2 = gmsh.model.geo.extrude(ov(2,:), 0, 0, 0.12);  %#ok<NASGU>

gmsh.model.geo.mesh.setSize([0 103; 0 105; 0 109; 0 102; 0 28; 0 24; 0 6; 0 5], ...
                            lc * 3);

gmsh.model.geo.synchronize();
gmsh.model.addPhysicalGroup(3, [129, 130], 1, "The volume");

gmsh.model.mesh.generate(3);
gmsh.write("t2.msh");

% gmsh.fltk.run("t2.opt");  % GUI; skipped in batch.

gmsh.finalize();
