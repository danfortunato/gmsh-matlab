gmsh.initialize();
fprintf('%g\n', gmsh.option.getNumber("Mesh.Algorithm"));

try, gmsh.open("square.msh"); catch, end  % only present on a re-run

gmsh.model.add("square");
gmsh.model.geo.addPoint(0, 0, 0, 0.1, 1);
gmsh.model.geo.addPoint(1, 0, 0, 0.1, 2);
gmsh.model.geo.addPoint(1, 1, 0, 0.1, 3);
gmsh.model.geo.addPoint(0, 1, 0, 0.1, 4);
gmsh.model.geo.addLine(1, 2, 1);
gmsh.model.geo.addLine(2, 3, 2);
gmsh.model.geo.addLine(3, 4, 3);
line4 = gmsh.model.geo.addLine(4, 1);
fprintf('line4 received tag %d\n', line4);
gmsh.model.geo.addCurveLoop([1, 2, 3, line4], 1);
gmsh.model.geo.addPlaneSurface([1], 6);
gmsh.model.geo.synchronize();

ptag = gmsh.model.addPhysicalGroup(1, [1, 2, 3, 4]);
ent = gmsh.model.getEntitiesForPhysicalGroup(1, ptag);
fprintf('new physical group %d: %s\n', ptag, mat2str(ent));

gmsh.model.addPhysicalGroup(2, [6]);

fprintf('%s\n', gmsh.option.getString("General.BuildOptions"));
fprintf('%g\n', gmsh.option.getNumber("Mesh.Algorithm"));
gmsh.option.setNumber("Mesh.Algorithm", 3.0);
fprintf('%g\n', gmsh.option.getNumber("Mesh.Algorithm"));
gmsh.model.mesh.generate(2);

gmsh.write("square.msh");

fprintf('Entities\n');
entities = gmsh.model.getEntities();
for k = 1:size(entities, 1)
    e = entities(k, :);
    fprintf('entity (%d, %d)\n', e(1), e(2));
    [types, tags, nodes] = gmsh.model.mesh.getElements(e(1), e(2));
    for j = 1:numel(types)
        fprintf('type %d\n', types(j));
        fprintf('tags : %s\n', mat2str(tags{j}));
        fprintf('nodes : %s\n', mat2str(nodes{j}));
    end
    if e(1) == 2 && e(2) == 6
        gmsh.model.mesh.addElements(e(1), e(2), types, ...
            {tags{1}(1:10)}, {nodes{1}(1:30)});
    end
end

gmsh.write("mesh_truncated.msh");
fprintf('Nodes\n');
[tags, coord, ~] = gmsh.model.mesh.getNodes(2, 6);
disp(tags);
disp(coord);
gmsh.finalize();
