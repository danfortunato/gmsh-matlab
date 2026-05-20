gmsh.initialize();

% Right patch (x >= 0).
gmsh.model.occ.addPoint(0.1, 0, -0.1);
gmsh.model.occ.addPoint(1,   0,  0);
gmsh.model.occ.addPoint(2,   0,  0);
gmsh.model.occ.addPoint(3,   0,  0);
gmsh.model.occ.addPoint(4,   0,  0);
gmsh.model.occ.addPoint(0.1, 1,  0.1);
gmsh.model.occ.addPoint(1,   1,  0);
gmsh.model.occ.addPoint(2,   1,  0);
gmsh.model.occ.addPoint(3,   1,  0);
gmsh.model.occ.addPoint(4,   1,  0);
gmsh.model.occ.addPoint(0,   2,  0.2);
gmsh.model.occ.addPoint(1,   2,  0);
gmsh.model.occ.addPoint(2,   2,  1.5);
gmsh.model.occ.addPoint(3,   2,  0);
gmsh.model.occ.addPoint(4,   2,  0);
gmsh.model.occ.addPoint(0,   3,  0.1);
gmsh.model.occ.addPoint(1,   3,  0);
gmsh.model.occ.addPoint(2,   3,  0);
gmsh.model.occ.addPoint(3,   3,  0);
gmsh.model.occ.addPoint(4,   3,  0);

% Left patch (x <= 0).
gmsh.model.occ.addPoint(0.1, 0, -0.1);
gmsh.model.occ.addPoint(-1, 0, 0);
gmsh.model.occ.addPoint(-2, 0, 0);
gmsh.model.occ.addPoint(-3, 0, 0);
gmsh.model.occ.addPoint(-4, 0, 0);
gmsh.model.occ.addPoint(0.1, 1, 0.1);
gmsh.model.occ.addPoint(-1, 1, 0);
gmsh.model.occ.addPoint(-2, 1, 0);
gmsh.model.occ.addPoint(-3, 1, 0);
gmsh.model.occ.addPoint(-4, 1, 0);
gmsh.model.occ.addPoint(0,   2, 0.2);
gmsh.model.occ.addPoint(-1, 2, 0);
gmsh.model.occ.addPoint(-2, 2, 1.5);
gmsh.model.occ.addPoint(-3, 2, 0);
gmsh.model.occ.addPoint(-4, 2, 0);
gmsh.model.occ.addPoint(0,   3, 0.1);
gmsh.model.occ.addPoint(-1, 3, 0);
gmsh.model.occ.addPoint(-2, 3, 0);
gmsh.model.occ.addPoint(-3, 3, 0);
gmsh.model.occ.addPoint(-4, 3, 0);

bezier = true;
if bezier
    gmsh.model.occ.addBezierSurface(1:20,  5);
    gmsh.model.occ.addBezierSurface(21:40, 5);
else
    gmsh.model.occ.addBSplineSurface(1:20,  5);
    gmsh.model.occ.addBSplineSurface(21:40, 5);
end

% Method 1: healShapes performs surface sewing (reorients normals too).
method = 1;
if method == 1
    gmsh.model.occ.healShapes();
elseif method == 2
    gmsh.model.occ.fragment(gmsh.model.occ.getEntities(0), ...
        gmsh.model.occ.getEntities(2));
elseif method == 3
    gmsh.model.occ.removeAllDuplicates();
end

gmsh.model.occ.synchronize();
gmsh.finalize();
