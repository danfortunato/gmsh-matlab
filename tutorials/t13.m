% Gmsh MATLAB tutorial 13 — Remeshing an STL file without an underlying CAD model.

gmsh.initialize();

gmsh.onelab.set(['[', ...
  '{"type":"number","name":"Parameters/Angle for surface detection","values":[40],"min":20,"max":120,"step":1},', ...
  '{"type":"number","name":"Parameters/Create surfaces guaranteed to be parametrizable","values":[0],"choices":[0,1]},', ...
  '{"type":"number","name":"Parameters/Apply funny mesh size field?","values":[0],"choices":[0,1]}', ...
  ']']);

createGeometryAndMesh();
gmsh.finalize();

function createGeometryAndMesh()
    gmsh.clear();
    gmsh.merge("t13_data.stl");

    angle = gmsh.onelab.getNumber("Parameters/Angle for surface detection");
    angle = angle(1);
    forceParametrizablePatches = gmsh.onelab.getNumber( ...
        "Parameters/Create surfaces guaranteed to be parametrizable");
    forceParametrizablePatches = logical(forceParametrizablePatches(1));

    includeBoundary = true;
    curveAngle = 180;

    gmsh.model.mesh.classifySurfaces(angle * pi/180, includeBoundary, ...
                                      forceParametrizablePatches, ...
                                      curveAngle * pi/180);

    gmsh.model.mesh.createGeometry([]);

    s = gmsh.model.getEntities(2);
    surface_tags = s(:,2);
    l = gmsh.model.geo.addSurfaceLoop(surface_tags);
    gmsh.model.geo.addVolume([l]);

    gmsh.model.geo.synchronize();

    f = gmsh.model.mesh.field.add("MathEval", -1);
    funny = gmsh.onelab.getNumber("Parameters/Apply funny mesh size field?");
    if funny(1)
        gmsh.model.mesh.field.setString(f, "F", "2*Sin((x+y)/5) + 3");
    else
        gmsh.model.mesh.field.setString(f, "F", "4");
    end
    gmsh.model.mesh.field.setAsBackgroundMesh(f);

    gmsh.model.mesh.generate(3);
    gmsh.write("t13.msh");
end
