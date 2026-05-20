% -----------------------------------------------------------------------------
%
%  Gmsh MATLAB extended tutorial 4
%
%  Post-processing data import: model-based
%
% -----------------------------------------------------------------------------

gmsh.initialize();

% First model: a discrete surface with 4 nodes and 2 triangles.
gmsh.model.add("simple model");
surf = gmsh.model.addDiscreteEntity(2);

gmsh.model.mesh.addNodes(2, surf, ...
    [1, 2, 3, 4], ...
    [0., 0., 0., 1., 0., 0., 1., 1., 0., 0., 1., 0.]);
gmsh.model.mesh.addElementsByType(surf, 2, [1, 2], [1, 2, 3, 1, 3, 4]);

% Model-based view: 10 steps of NodeData on the discrete surface.
t1 = gmsh.view.add("Continuous");
for step = 0:9
    gmsh.view.addHomogeneousModelData( ...
        t1, step, "simple model", "NodeData", ...
        [1, 2, 3, 4], ...
        [10., 10., 12. + step, 13. + step]);
end

% Second view: discontinuous ElementNodeData on the same model.
t2 = gmsh.view.add("Discontinuous");
for step = 0:9
    gmsh.view.addHomogeneousModelData( ...
        t2, step, "simple model", "ElementNodeData", ...
        [1, 2], ...
        [10., 10., 12. + step, 14., 15., 13. + step]);
end

% Second model: a meshed unit cube.
gmsh.model.add("another model");
gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate(3);

[nodes, coord, ~] = gmsh.model.mesh.getNodes();
% Build per-node scalar data = step * x-coordinate.
for step = 11:19
    scalar = step * double(coord(1:3:end));
    gmsh.view.addHomogeneousModelData( ...
        t1, step, "another model", "NodeData", nodes, scalar);
end

gmsh.view.write(t1, "x4_t1.msh");
gmsh.view.write(t2, "x4_t2.msh");

gmsh.finalize();
