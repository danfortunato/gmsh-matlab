% Gmsh MATLAB tutorial 4 — Holes in surfaces, annotations, entity colors.

gmsh.initialize();
gmsh.model.add("t4");

cm = 1e-2;
e1 = 4.5 * cm; e2 = 6 * cm / 2; e3 = 5 * cm / 2;
h1 = 5 * cm;   h2 = 10 * cm;    h3 = 5 * cm; h4 = 2 * cm; h5 = 4.5 * cm;
R1 = 1 * cm;   R2 = 1.5 * cm;   r = 1 * cm;
Lc1 = 0.01;    Lc2 = 0.003;

hyp = @(a, b) sqrt(a*a + b*b);
ccos = (-h5 * R1 + e2 * hyp(h5, hyp(e2, R1))) / (h5 * h5 + e2 * e2);
ssin = sqrt(1 - ccos * ccos);

gmsh.model.geo.addPoint(-e1-e2, 0, 0, Lc1, 1);
gmsh.model.geo.addPoint(-e1-e2, h1, 0, Lc1, 2);
gmsh.model.geo.addPoint(-e3-r,  h1, 0, Lc2, 3);
gmsh.model.geo.addPoint(-e3-r,  h1+r, 0, Lc2, 4);
gmsh.model.geo.addPoint(-e3,    h1+r, 0, Lc2, 5);
gmsh.model.geo.addPoint(-e3,    h1+h2, 0, Lc1, 6);
gmsh.model.geo.addPoint( e3,    h1+h2, 0, Lc1, 7);
gmsh.model.geo.addPoint( e3,    h1+r, 0, Lc2, 8);
gmsh.model.geo.addPoint( e3+r,  h1+r, 0, Lc2, 9);
gmsh.model.geo.addPoint( e3+r,  h1, 0, Lc2, 10);
gmsh.model.geo.addPoint( e1+e2, h1, 0, Lc1, 11);
gmsh.model.geo.addPoint( e1+e2, 0, 0, Lc1, 12);
gmsh.model.geo.addPoint( e2,    0, 0, Lc1, 13);

gmsh.model.geo.addPoint( R1/ssin, h5+R1*ccos, 0, Lc2, 14);
gmsh.model.geo.addPoint( 0,       h5,         0, Lc2, 15);
gmsh.model.geo.addPoint(-R1/ssin, h5+R1*ccos, 0, Lc2, 16);
gmsh.model.geo.addPoint(-e2,      0,          0, Lc1, 17);

gmsh.model.geo.addPoint(-R2, h1+h3,    0, Lc2, 18);
gmsh.model.geo.addPoint(-R2, h1+h3+h4, 0, Lc2, 19);
gmsh.model.geo.addPoint( 0,  h1+h3+h4, 0, Lc2, 20);
gmsh.model.geo.addPoint( R2, h1+h3+h4, 0, Lc2, 21);
gmsh.model.geo.addPoint( R2, h1+h3,    0, Lc2, 22);
gmsh.model.geo.addPoint( 0,  h1+h3,    0, Lc2, 23);
gmsh.model.geo.addPoint( 0,  h1+h3+h4+R2, 0, Lc2, 24);
gmsh.model.geo.addPoint( 0,  h1+h3-R2,    0, Lc2, 25);

gmsh.model.geo.addLine(1, 17, 1);
gmsh.model.geo.addLine(17, 16, 2);
gmsh.model.geo.addCircleArc(14, 15, 16, 3);
gmsh.model.geo.addLine(14, 13, 4);
gmsh.model.geo.addLine(13, 12, 5);
gmsh.model.geo.addLine(12, 11, 6);
gmsh.model.geo.addLine(11, 10, 7);
gmsh.model.geo.addCircleArc(8, 9, 10, 8);
gmsh.model.geo.addLine(8, 7, 9);
gmsh.model.geo.addLine(7, 6, 10);
gmsh.model.geo.addLine(6, 5, 11);
gmsh.model.geo.addCircleArc(3, 4, 5, 12);
gmsh.model.geo.addLine(3, 2, 13);
gmsh.model.geo.addLine(2, 1, 14);
gmsh.model.geo.addLine(18, 19, 15);
gmsh.model.geo.addCircleArc(21, 20, 24, 16);
gmsh.model.geo.addCircleArc(24, 20, 19, 17);
gmsh.model.geo.addCircleArc(18, 23, 25, 18);
gmsh.model.geo.addCircleArc(25, 23, 22, 19);
gmsh.model.geo.addLine(21, 22, 20);

gmsh.model.geo.addCurveLoop([17, -15, 18, 19, -20, 16], 21);
gmsh.model.geo.addPlaneSurface([21], 22);
gmsh.model.geo.addCurveLoop([11, -12, 13, 14, 1, 2, -3, 4, 5, 6, 7, -8, 9, 10], 23);
gmsh.model.geo.addPlaneSurface([23, 21], 24);

gmsh.model.geo.synchronize();

v = gmsh.view.add("comments", -1);
gmsh.view.addListDataString(v, [10, -10], {'Created with Gmsh'}, {});
gmsh.view.addListDataString(v, [0, 0.11, 0], {'Hole'}, {'Align', 'Center', 'Font', 'Helvetica'});

% Skip the image annotations — they reference t4_image.png which isn't
% required for the mesh output, only for GUI.

% Change entity colours (no effect on mesh).
gmsh.model.setColor([2 22], 127, 127, 127, 255, false);
gmsh.model.setColor([2 24], 160,  32, 240, 255, false);
dims = ones(14,1); tags = (1:14).';
gmsh.model.setColor([dims tags], 255, 0, 0, 255, false);
dims = ones(6,1); tags = (15:20).';
gmsh.model.setColor([dims tags], 255, 255, 0, 255, false);

gmsh.model.mesh.generate(2);
gmsh.write("t4.msh");
gmsh.finalize();
