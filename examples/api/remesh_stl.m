gmsh.initialize();

% Load STL file.
here = fileparts(mfilename('fullpath'));
gmsh.merge(fullfile(here, 'object.stl'));

remesh_surface = true;

if remesh_surface
    gmsh.option.setNumber("Mesh.Algorithm", 6);
    gmsh.option.setNumber("Mesh.MeshSizeMin", 0.75);
    gmsh.option.setNumber("Mesh.MeshSizeMax", 0.75);

    % Split input surface mesh based on a 40-degree angle threshold and
    % generate new discrete surfaces suitable for reparametrization.
    gmsh.model.mesh.classifySurfaces(40 * pi / 180, true, true);
    gmsh.model.mesh.createGeometry();
end

% All surfaces.
s = gmsh.model.getEntities(2);

% Surface loop from all surfaces.
l = gmsh.model.geo.addSurfaceLoop(s(:, 2).');
gmsh.model.geo.addVolume([l]);

gmsh.model.geo.synchronize();
gmsh.model.mesh.generate(3);

gmsh.finalize();
