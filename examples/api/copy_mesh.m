gmsh.initialize();

% Create model1, mesh it.
gmsh.model.add('model1');
gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate(3);

% Snapshot the mesh, keyed by entity.
ents = gmsh.model.getEntities();
nE = size(ents, 1);
snap = cell(1, nE);    % {bnd, {nodeTags,coord,parCoord}, {types,tags,nodeTags}}
for k = 1:nE
    d = ents(k, 1); t = ents(k, 2);
    bnd_k = gmsh.model.getBoundary(ents(k, :));
    [nt, nc, np] = gmsh.model.mesh.getNodes(d, t);
    [et, etgs, ent_] = gmsh.model.mesh.getElements(d, t);
    snap{k} = {bnd_k, {nt, nc, np}, {et, etgs, ent_}};
end

% Create model2, populate from snapshot.
gmsh.model.add('model2');
for k = 1:nE
    d = ents(k, 1); t = ents(k, 2);
    bnd_tags = snap{k}{1}(:, 2).';
    gmsh.model.addDiscreteEntity(d, t, bnd_tags);
    gmsh.model.mesh.addNodes(d, t, snap{k}{2}{1}, snap{k}{2}{2});
    gmsh.model.mesh.addElements(d, t, ...
        snap{k}{3}{1}, snap{k}{3}{2}, snap{k}{3}{3});
end

% Build a post-processing view on model2.
view = gmsh.view.add('bgView');
[nodes, coord, ~] = gmsh.model.mesh.getNodes();
scalar = double(coord(1:3:end)) / 10 + 0.01;
gmsh.view.addHomogeneousModelData(view, 0, 'model2', 'NodeData', nodes, scalar);

% Use the view as a background mesh-size field for model1.
gmsh.model.setCurrent('model1');
field = gmsh.model.mesh.field.add("PostView");
gmsh.model.mesh.field.setNumber(field, "ViewTag", view);
gmsh.model.mesh.field.setAsBackgroundMesh(field);

gmsh.option.setNumber("Mesh.MeshSizeExtendFromBoundary", 0);
gmsh.option.setNumber("Mesh.Algorithm3D", 10);
gmsh.model.mesh.clear();
gmsh.model.mesh.generate(3);

gmsh.finalize();
