% Contributed by Zoltan Csati (Python original).

gmsh.initialize();

tag = gmsh.view.add('Linear field on a quadratic segment');

segment = [-2,  3,  -1, ...
            9, 14,  12.5, ...
            0,  0,   0];

u = [1, 3.5];
segment = [segment, u];

P = [0, 0, 0, ...
     1, 0, 0];
Phi = [1/2, -1/2, ...
       1/2,  1/2];
P_g = [0, 0, 0, ...
       1, 0, 0, ...
       2, 0, 0];
Phi_g = [0, -1/2, 1/2, ...
         0,  1/2, 1/2, ...
         1,  0,  -1];

gmsh.view.setInterpolationMatrices(tag, 'Line', 2, Phi, P, 3, Phi_g, P_g);
gmsh.view.addListData(tag, 'SL', 1, segment);

gmsh.view.option.setNumber(tag, "AdaptVisualizationGrid", 1);
gmsh.view.option.setNumber(tag, "TargetError", -1);
gmsh.view.option.setNumber(tag, "MaxRecursionLevel", 7);

gmsh.view.option.setNumber(tag, 'LineWidth', 10);
gmsh.view.option.setNumber(tag, 'IntervalsType', 3);
gmsh.view.option.setNumber(tag, 'LineType', 1);
gmsh.view.option.setNumber(tag, 'GlyphLocation', 2);
gmsh.view.option.setNumber(tag, 'Axes', 2);
gmsh.view.option.setNumber(tag, 'Explode', 0.8);

gmsh.finalize();
