% Gmsh MATLAB tutorial 3 — Extruded meshes, ONELAB parameters, options.
% GUI loop and live ONELAB checkbox events are skipped; we just build the mesh.

gmsh.initialize();

% Options: number points, set colours (purely cosmetic — won't affect mesh).
gmsh.option.setNumber("Geometry.PointNumbers", 1);
gmsh.option.setColor("Geometry.Color.Points", 255, 165, 0, 255);
gmsh.option.setColor("General.Color.Text", 255, 255, 255, 255);
gmsh.option.setColor("Mesh.Color.Points", 255, 0, 0, 255);
[r, g, b, a] = gmsh.option.getColor("Geometry.Points");
gmsh.option.setColor("Geometry.Surfaces", r, g, b, a);

% ONELAB parameter for the twist angle.
gmsh.onelab.set(['[', ...
  '{"type":"number","name":"Parameters/Twisting angle","values":[90],', ...
  '"min":0,"max":120,"step":1}', ...
  ']']);

createGeometryAndMesh();
gmsh.finalize();

function createGeometryAndMesh()
    gmsh.clear();
    gmsh.model.add("t3");

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

    h = 0.1;
    ov = gmsh.model.geo.extrude([2 1], 0, 0, h, [8, 2], [0.5, 1.0], false);  %#ok<NASGU>

    ov = gmsh.model.geo.revolve([2 28], -0.1, 0, 0.1, 0, 1, 0, -pi/2, [7], [], false);  %#ok<NASGU>

    angle = gmsh.onelab.getNumber('Parameters/Twisting angle');
    angle = angle(1);
    ov = gmsh.model.geo.twist([2 50], 0, 0.15, 0.25, -2*h, 0, 0, 1, 0, 0, ...
                              angle * pi / 180, [10], [], true);

    gmsh.model.geo.synchronize();
    gmsh.model.addPhysicalGroup(3, [1, 2, ov(2,2)], 101);

    gmsh.model.mesh.generate(3);
    gmsh.write("t3.msh");
end
