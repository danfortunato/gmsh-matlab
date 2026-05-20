gmsh.initialize();
gmsh.model.occ.addBox(0,0,0, 1,1,1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate();
[~, tags, ~] = gmsh.model.mesh.getElements(3);
qual = gmsh.model.mesh.getElementQualities(tags{1}, "minEdge");
[mn, ix] = min(qual);
fprintf('(%g, %d)\n', mn, tags{1}(ix));
gmsh.finalize();
