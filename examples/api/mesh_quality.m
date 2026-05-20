gmsh.initialize();

gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate(3);

[~, eleTags, ~] = gmsh.model.mesh.getElements(3);
q = gmsh.model.mesh.getElementQualities(eleTags{1}, "minSICN");
fprintf('%d tets, qualities range [%g, %g]\n', numel(q), min(q), max(q));

gmsh.plugin.setNumber("AnalyseMeshQuality", "ICNMeasure", 1.);
gmsh.plugin.setNumber("AnalyseMeshQuality", "CreateView", 1.);
t = gmsh.plugin.run("AnalyseMeshQuality");
[~, tags, data, ~, ~] = gmsh.view.getModelData(t, 0);
fprintf('ICN for element %d = %g\n', tags(1), data{1}(1));

gmsh.finalize();
