gmsh.initialize();

t2 = gmsh.view.add("Second order quad");

% Coordinates of 4 quad nodes.
quad = [0., 1., 1., 0., ...
       -1.2, -1.2, -0.2, -0.2, ...
        0., 0., 0., 0.];

% 9 values to be interpolated by second-order basis functions.
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

gmsh.view.option.setNumber(t2, "AdaptVisualizationGrid", 1);
gmsh.view.option.setNumber(t2, "TargetError", 1e-2);
gmsh.view.option.setNumber(t2, "MaxRecursionLevel", 6);

% Get adaptive visualization data.
[dataType, numElements, data] = gmsh.view.getListData(t2, true);

surf = gmsh.model.addDiscreteEntity(2);

N = 1;
for k = 1:numel(dataType)
    if strcmp(dataType{k}, 'SQ')
        coord = []; tags = []; ele = [];
        for q = 0:numElements(k) - 1
            base = 16 * q;
            coord = [coord, data{k}(base+1), data{k}(base+5), data{k}(base+9)];   %#ok<AGROW>
            coord = [coord, data{k}(base+2), data{k}(base+6), data{k}(base+10)];  %#ok<AGROW>
            coord = [coord, data{k}(base+3), data{k}(base+7), data{k}(base+11)];  %#ok<AGROW>
            coord = [coord, data{k}(base+4), data{k}(base+8), data{k}(base+12)];  %#ok<AGROW>
            tags  = [tags, N, N+1, N+2, N+3]; %#ok<AGROW>
            ele   = [ele,  N, N+1, N+2, N+3]; %#ok<AGROW>
            N = N + 4;
        end
        gmsh.model.mesh.addNodes(2, 1, tags, coord);
        gmsh.model.mesh.addElementsByType(surf, 3, [], ele);
    end
end

gmsh.model.mesh.removeDuplicateNodes();
gmsh.write('test.msh');

gmsh.finalize();
