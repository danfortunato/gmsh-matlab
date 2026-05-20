gmsh.initialize();

% From discrete.py:
gmsh.model.add("test");
gmsh.model.addDiscreteEntity(2, 1);
gmsh.model.mesh.addNodes(2, 1, [1, 2, 3, 4], ...
    [0., 0., 0., 1., 0., 0., 1., 1., 0., 0., 1., 0.]);
gmsh.model.mesh.addElements(2, 1, [2], {[1, 2]}, {[1, 2, 3, 1, 3, 4]});

% Create a view with some data.
t = gmsh.view.add("some data");
gmsh.view.addModelData(t, 0, "test", "NodeData", ...
    [1, 2, 3, 4], {[1.], [10.], [20.], [1.]});

% Get the data back.
[dataType, tags, ~, ~, ~] = gmsh.view.getModelData(t, 0);
disp(dataType); disp(tags);

% Compute the iso-curve at value 11.
gmsh.plugin.setNumber("Isosurface", "Value", 11.);
gmsh.plugin.run("Isosurface");

% Delete the source view.
gmsh.view.remove(t);

% Check how many views the plugin created.
tags = gmsh.view.getTags();
if numel(tags) == 1
    gmsh.view.write(tags(1), "iso.msh");
    [dataTypes, numElements, ~] = gmsh.view.getListData(tags(1));
    disp(dataTypes); disp(numElements);
end

gmsh.finalize();
