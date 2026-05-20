% -----------------------------------------------------------------------------
%
%  Gmsh MATLAB extended tutorial 3
%
%  Post-processing data import: list-based
%
% -----------------------------------------------------------------------------

gmsh.initialize();

% List-based view holding scalar triangles plus a vector line.
t1 = gmsh.view.add("A list-based view");

triangle1 = [0., 1., 1., ...   % x of 3 nodes
             0., 0., 1., ...   % y
             0., 0., 0.];      % z
triangle2 = [0., 1., 0., 0., 1., 1., 0., 0., 0.];

% Append 10 time steps of nodal values for each triangle.
for step = 0:9
    triangle1 = [triangle1, 10., 11. - step, 12.]; %#ok<AGROW>
    triangle2 = [triangle2, 11., 12., 13. + step]; %#ok<AGROW>
end

gmsh.view.addListData(t1, "ST", 2, [triangle1, triangle2]);

% Vector line.
line = [0., 1., ...   % x of 2 nodes
        1.2, 1.2, ... % y
        0., 0.];      % z
for step = 0:9
    line = [line, 10. + step, 0., 0., 10. + step, 0., 0.]; %#ok<AGROW>
end
gmsh.view.addListData(t1, "VL", 1, line);

% 2D and 3D strings.
gmsh.view.addListDataString(t1, [20., -20.], {'Created with Gmsh'});
gmsh.view.addListDataString(t1, [0.5, 1.5, 0.], ...
    {'A multi-step list-based view'}, ...
    {'Align', 'Center', 'Font', 'Helvetica'});

% Query and tweak view options.
gmsh.view.option.setNumber(t1, "TimeStep", 5);
gmsh.view.option.setNumber(t1, "IntervalsType", 3);
ns = gmsh.view.option.getNumber(t1, "NbTimeStep");
fprintf('View %d has %g time steps\n', t1, ns);

probe_val = gmsh.view.probe(t1, 0.9, 0.1, 0);
fprintf('Value at (0.9, 0.1, 0) = %s\n', mat2str(probe_val));

gmsh.view.write(t1, "x3.pos");

% Second view: high-order quad with explicit interpolation matrices.
t2 = gmsh.view.add("Second order quad");

quad = [0., 1., 1., 0., ...     % x of 4 nodes
       -1.2, -1.2, -0.2, -0.2, ... % y
        0., 0., 0., 0.];        % z
quad = [quad, 1., 1., 1., 1., 3., 3., 3., 3., -3.];

cmat = [0, 0, 0.25, 0, 0, -0.25, -0.25, 0, 0.25, ...
        0, 0, 0.25, 0, 0, -0.25, 0.25, 0, -0.25, ...
        0, 0, 0.25, 0, 0, 0.25, 0.25, 0, 0.25, ...
        0, 0, 0.25, 0, 0, 0.25, -0.25, 0, -0.25, ...
        0, 0, -0.5, 0.5, 0, 0.5, 0, -0.5, 0, ...
        0, 0.5, -0.5, 0, 0.5, 0, -0.5, 0, 0, ...
        0, 0, -0.5, 0.5, 0, -0.5, 0, 0.5, 0, ...
        0, 0.5, -0.5, 0, -0.5, 0, 0.5, 0, 0, ...
        1, -1, 1, -1, 0, 0, 0, 0, 0];
emat = [0, 0, 0, ...
        2, 0, 0, ...
        2, 2, 0, ...
        0, 2, 0, ...
        1, 0, 0, ...
        2, 1, 0, ...
        1, 2, 0, ...
        0, 1, 0, ...
        1, 1, 0];

gmsh.view.setInterpolationMatrices(t2, "Quadrangle", 9, cmat, emat);
gmsh.view.addListData(t2, "SQ", 1, quad);

% Adaptive visualization options.
gmsh.view.option.setNumber(t2, "AdaptVisualizationGrid", 1);
gmsh.view.option.setNumber(t2, "TargetError", 1e-2);
gmsh.view.option.setNumber(t2, "MaxRecursionLevel", 5);

gmsh.finalize();
