% Contributed by Zoltan Csati (Python original).

gmsh.initialize();

tag = gmsh.view.add('Quadratic field on a quadratic segment');

% Coordinates of the quadratic segment (one element) in physical space.
segment = [-2,  3,  -1, ...     % x
            9, 14,  12.5, ...   % y
            0,  0,   0];        % z

% Appended with 3 function values.
u = [1, 3.5, -1];
segment = [segment, u];

% Canonical polynomial basis for field interpolation.
P = [0, 0, 0, ...   % xi^0 eta^0 zeta^0
     1, 0, 0, ...   % xi^1 eta^0 zeta^0
     2, 0, 0];      % xi^2 eta^0 zeta^0

% Monomial -> Lagrange basis.
Phi = [0, -1/2, 1/2, ...
       0,  1/2, 1/2, ...
       1,  0,  -1];

% Geometric mapping uses the same monomials.
P_g   = P;
Phi_g = Phi;

gmsh.view.setInterpolationMatrices(tag, 'Line', 3, Phi, P, 3, Phi_g, P_g);

gmsh.view.addListData(tag, 'SL', 1, segment);

gmsh.view.option.setNumber(tag, "AdaptVisualizationGrid", 1);
gmsh.view.option.setNumber(tag, "TargetError", 1e-3);
gmsh.view.option.setNumber(tag, "MaxRecursionLevel", 7);

gmsh.view.option.setNumber(tag, 'LineWidth', 10);
gmsh.view.option.setNumber(tag, 'IntervalsType', 3);
gmsh.view.option.setNumber(tag, 'LineType', 1);
gmsh.view.option.setNumber(tag, 'GlyphLocation', 2);
gmsh.view.option.setNumber(tag, 'Axes', 2);
gmsh.view.option.setNumber(tag, 'Explode', 0.8);

gmsh.finalize();
