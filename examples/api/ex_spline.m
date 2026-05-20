gmsh.initialize();

gmsh.model.add("spline");

for i = 1:10
    gmsh.model.occ.addPoint(i, sin(i/9 * 2*pi), 0, 0.1, i);
end

gmsh.model.occ.addSpline(1:10, 1);
gmsh.model.occ.addBSpline(1:10, 2);
gmsh.model.occ.addBezier(1:10, 3);

% With begin/end tangents.
gmsh.model.occ.addSpline(1:10, 4, [0, 1, 0, 0, 1, 0]);

% With tangents at each point.
gmsh.model.occ.addSpline(1:10, 5, ...
    [1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, ...
     1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0]);

gmsh.model.occ.addPoint(0.2, -1.6, 0, 0.1, 101);
gmsh.model.occ.addPoint(1.2, -1.6, 0, 0.1, 102);
gmsh.model.occ.addPoint(1.2, -1.1, 0, 0.1, 103);
gmsh.model.occ.addPoint(0.3, -1.1, 0, 0.1, 104);
gmsh.model.occ.addPoint(0.7, -1.0, 0, 0.1, 105);

% Periodic bspline through the control points.
gmsh.model.occ.addSpline([103, 102, 101, 104, 105, 103], 100);
gmsh.model.occ.addBSpline([103, 102, 101, 104, 105, 103], 101);

% General bspline with explicit degree, knots and multiplicities.
gmsh.model.occ.addPoint(0, -2, 0, 0.1, 201);
gmsh.model.occ.addPoint(1, -2, 0, 0.1, 202);
gmsh.model.occ.addPoint(1, -3, 0, 0.1, 203);
gmsh.model.occ.addPoint(0, -3, 0, 0.1, 204);
gmsh.model.occ.addBSpline([201, 202, 203, 204], 200, 2, [], [0, 0.5, 1], [3, 1, 3]);

gmsh.model.occ.synchronize();
gmsh.finalize();
