gmsh.initialize();

% Cube with sphere inclusion.
cube   = [3, gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1)];
sphere = [3, gmsh.model.occ.addSphere(0.5, 0.5, 0.5, 0.2)];
[~, frag_map] = gmsh.model.occ.fragment(cube, sphere);
out = frag_map{1}(1, :);   % first mapping's first replacement
gmsh.model.occ.synchronize();

% Generate a mesh.
gmsh.option.setNumber('Mesh.MeshSizeFactor', 0.3);
gmsh.model.mesh.generate(3);

% Remove the mesh outside the sphere.
gmsh.model.mesh.clear(out);

% Get all entities making up the sphere (surfaces, curves, points).
s = gmsh.model.getBoundary(sphere, false, false);
c = gmsh.model.getBoundary(s, false, false);
p = gmsh.model.getBoundary(c, false, false);
c = unique(c, 'rows', 'stable');
p = unique(p, 'rows', 'stable');

% Move the mesh of the sphere via an affine transform.
gmsh.model.mesh.affineTransform( ...
    [1, 0, 0, 0.2, 0, 1, 0, 0, 0, 0, 1, 0], ...
    [sphere; s; c; p]);

% Mesh only the empty entities.
gmsh.option.setNumber('Mesh.MeshOnlyEmpty', 1);
gmsh.model.mesh.generate(3);

gmsh.finalize();
