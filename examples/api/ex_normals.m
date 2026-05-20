gmsh.initialize();
gmsh.model.add("normals");
gmsh.model.occ.addSphere(0, 0, 0, 1);
gmsh.model.occ.addBox(2, 0, 0, 1, 1, 1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate(2);

nn = [];
cc = [];

ent = gmsh.model.getEntities(2);
for k = 1:size(ent, 1)
    surf = ent(k, 2);
    [~, coord, param] = gmsh.model.mesh.getNodes(2, surf, true);
    coord = double(coord);
    param = double(param);
    normals = gmsh.model.getNormal(surf, param);
    curv    = gmsh.model.getCurvature(2, surf, param);
    for i = 1:3:numel(coord)
        nn(end+1) = coord(i);   nn(end+1) = coord(i+1); nn(end+1) = coord(i+2);    %#ok<AGROW>
        nn(end+1) = normals(i); nn(end+1) = normals(i+1); nn(end+1) = normals(i+2); %#ok<AGROW>
        cc(end+1) = coord(i);   cc(end+1) = coord(i+1); cc(end+1) = coord(i+2);    %#ok<AGROW>
        cc(end+1) = curv((i - 1)/3 + 1);                                            %#ok<AGROW>
    end
end

t = gmsh.view.add("normals");
gmsh.view.addListData(t, "VP", numel(nn) / 6, nn);
gmsh.view.write(t, "normals.pos");

t = gmsh.view.add("curvatures");
gmsh.view.addListData(t, "SP", numel(cc) / 4, cc);
gmsh.view.write(t, "curvatures.pos");

gmsh.finalize();
