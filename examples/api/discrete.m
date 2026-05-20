gmsh.initialize();

gmsh.model.add("test");

% Add discrete surface with tag 1.
gmsh.model.addDiscreteEntity(2, 1);

% 4 mesh nodes.
gmsh.model.mesh.addNodes(2, 1, ...
    [1, 2, 3, 4], ...
    [0., 0., 0., ...   % node 1
     1., 0., 0., ...   % node 2
     1., 1., 0., ...   % node 3
     0., 1., 0.]);     % node 4

% 2 triangles.
gmsh.model.mesh.addElements(2, 1, ...
    [2], ...           % single type: 3-node triangle
    {[1, 2]}, ...      % triangle tags
    {[1, 2, 3, 1, 3, 4]});

gmsh.write("test.msh");
gmsh.finalize();
