gmsh.initialize();

gmsh.model.occ.addRectangle(0, 0, 0, 1, 1, 1);
gmsh.model.occ.addRectangle(2, 0, 0, 1, 1, 2);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate(2);

% Removing an entity's mesh requires it not to be on the boundary of another
% entity with a non-empty mesh (nodes are shared).
gmsh.model.mesh.clear([2, 2]);   % ok to remove mesh of surface 2
gmsh.model.mesh.clear([1, 1]);   % not ok (boundary of surface 1)

% Removing all elements from an entity is always allowed.
gmsh.model.mesh.removeElements(1, 1);

% Remove specific elements.
[~, tags, ~] = gmsh.model.mesh.getElements(1, 2);
gmsh.model.mesh.removeElements(1, 2, tags{1}(1:3));

gmsh.write('remove_elements_no_reclassify.msh');

% Reclassify nodes to conform to gmsh's data model.
gmsh.model.mesh.reclassifyNodes();
gmsh.write('remove_elements_reclassify.msh');

gmsh.finalize();
