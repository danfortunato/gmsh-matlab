gmsh.initialize();

% From discrete.py:
gmsh.model.add("test");
gmsh.model.addDiscreteEntity(2, 1);
gmsh.model.mesh.addNodes(2, 1, [1, 2, 3, 4], ...
    [0., 0., 0., 1., 0., 0., 1., 1., 0., 0., 1., 0.]);
gmsh.model.mesh.addElements(2, 1, [2], {[1, 2]}, {[1, 2, 3, 1, 3, 4]});

% Create a new post-processing view.
t = gmsh.view.add("some data");

% Add 10 steps of model-based data, on the nodes of the mesh.
for step = 0:9
    gmsh.view.addModelData( ...
        t, step, "test", "NodeData", ...
        [1, 2, 3, 4], ...
        {[10.], [10.], [12. + step], [13. + step]});
end

gmsh.view.write(t, "data.msh");
gmsh.finalize();
