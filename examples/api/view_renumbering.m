% Tests that mesh renumbering also correctly renumbers all dependent
% model-based views.

gmsh.initialize();

gmsh.model.add("simple model");
surf = gmsh.model.addDiscreteEntity(2);

gmsh.model.mesh.addNodes(2, surf, [11, 12, 13, 14], ...
    [0., 0., 0., 1., 0., 0., 1., 1., 0., 0., 1., 0.]);
gmsh.model.mesh.addElementsByType(surf, 2, [100, 102], [11, 12, 13, 11, 13, 14]);

t1 = gmsh.view.add("A nodal view");
for step = 0:9
    gmsh.view.addHomogeneousModelData(t1, step, "simple model", "NodeData", ...
        [11, 12, 13, 14], [10., 10., 12. + step, 13. + step]);
end

t2 = gmsh.view.add("An element view");
gmsh.view.addHomogeneousModelData(t2, 0, "simple model", "ElementData", ...
    [100, 102], [3.14, 6.28]);

gmsh.model.mesh.renumberNodes();
gmsh.model.mesh.renumberElements();

gmsh.finalize();
