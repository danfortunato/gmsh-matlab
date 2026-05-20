% -----------------------------------------------------------------------------
%
%  Gmsh MATLAB extended tutorial 5
%
%  Additional geometrical data: parametrizations, normals, curvatures
%
% -----------------------------------------------------------------------------

gmsh.initialize();

% Fuse a sphere and a box, then mesh the surfaces.
gmsh.model.add("x5");
s = gmsh.model.occ.addSphere(0, 0, 0, 1);
b = gmsh.model.occ.addBox(0.5, 0, 0, 1.3, 2, 3);
gmsh.model.occ.fuse([3, s], [3, b]);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate(2);

normals    = [];
curvatures = [];

surfaces = gmsh.model.getEntities(2);
for i = 1:size(surfaces, 1)
    sTag = surfaces(i, 2);

    [~, coord, param] = gmsh.model.mesh.getNodes(2, sTag, true);
    coord = double(coord);
    param = double(param);

    norm = gmsh.model.getNormal(sTag, param);
    curv = gmsh.model.getCurvature(2, sTag, param);

    for k = 1:3:numel(coord)
        normals(end+1)    = coord(k);     %#ok<AGROW>
        normals(end+1)    = coord(k+1);   %#ok<AGROW>
        normals(end+1)    = coord(k+2);   %#ok<AGROW>
        normals(end+1)    = norm(k);      %#ok<AGROW>
        normals(end+1)    = norm(k+1);    %#ok<AGROW>
        normals(end+1)    = norm(k+2);    %#ok<AGROW>
        curvatures(end+1) = coord(k);     %#ok<AGROW>
        curvatures(end+1) = coord(k+1);   %#ok<AGROW>
        curvatures(end+1) = coord(k+2);   %#ok<AGROW>
        curvatures(end+1) = curv((k-1)/3 + 1); %#ok<AGROW>
    end
end

% List-based vector view: surface normals at the mesh nodes.
vn = gmsh.view.add("normals");
gmsh.view.addListData(vn, "VP", numel(normals) / 6, normals);
gmsh.view.option.setNumber(vn, 'ShowScale', 0);
gmsh.view.option.setNumber(vn, 'ArrowSizeMax', 30);
gmsh.view.option.setNumber(vn, 'ColormapNumber', 19);

% List-based scalar view: surface curvature at the mesh nodes.
vc = gmsh.view.add("curvatures");
gmsh.view.addListData(vc, "SP", numel(curvatures) / 4, curvatures);
gmsh.view.option.setNumber(vc, 'ShowScale', 0);

% Reparametrize curve 5 on surface 1 and verify that the two evaluations agree.
[bmin, bmax] = gmsh.model.getParametrizationBounds(1, 5);
N = 20;
t = bmin(1) + (0:N-1) * (bmax(1) - bmin(1)) / N;
xyz1 = gmsh.model.getValue(1, 5, t);
uv   = gmsh.model.reparametrizeOnSurface(1, 5, t, 1);
xyz2 = gmsh.model.getValue(2, 1, uv);

if max(abs(xyz1 - xyz2)) < 1e-12
    gmsh.logger.write('Evaluation on curve and surface match!');
else
    gmsh.logger.write('Evaluation on curve and surface do not match!', 'error');
end

gmsh.finalize();
