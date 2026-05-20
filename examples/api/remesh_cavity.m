gmsh.initialize();

cube = gmsh.model.occ.addBox(0, 0, 0, 10, 10, 10);
gmsh.model.occ.synchronize();
gmsh.option.setNumber('Mesh.Algorithm3D', 10);
gmsh.option.setNumber('Mesh.MeshSizeMax', 0.3);
gmsh.model.mesh.generate(3);

% Remove some tetrahedra from the volume mesh via the Invisible plugin.
gmsh.plugin.setNumber("Invisible", "DeleteElements", 1.);
gmsh.plugin.setNumber("Invisible", "Inside", 1);
gmsh.plugin.setNumber("Invisible", "XMin", 2);
gmsh.plugin.setNumber("Invisible", "YMin", 4);
gmsh.plugin.setNumber("Invisible", "ZMin", 2);
gmsh.plugin.setNumber("Invisible", "XMax", 8);
gmsh.plugin.setNumber("Invisible", "YMax", 5);
gmsh.plugin.setNumber("Invisible", "ZMax", 8);
gmsh.plugin.run("Invisible");
gmsh.plugin.setNumber("Invisible", "XMin", 2);
gmsh.plugin.setNumber("Invisible", "YMin", 2);
gmsh.plugin.setNumber("Invisible", "ZMin", 4);
gmsh.plugin.setNumber("Invisible", "XMax", 3);
gmsh.plugin.setNumber("Invisible", "YMax", 8);
gmsh.plugin.setNumber("Invisible", "ZMax", 6);
gmsh.plugin.run("Invisible");

TRI = 2;   % first order triangle
TET = 4;   % first order tetrahedron

% Faces of remaining tets.
facenodes = gmsh.model.mesh.getElementFaceNodes(TET, 3, cube);
gmsh.model.mesh.createFaces([3, cube]);
[facetags, ~] = gmsh.model.mesh.getFaces(3, facenodes);

% Face -> [3 nodes] map.
facenodes = double(facenodes);
facetags  = double(facetags);
nF = numel(facetags);
facemap = containers.Map('KeyType', 'uint64', 'ValueType', 'any');
for i = 1:nF
    facemap(facetags(i)) = facenodes(3*(i-1)+1 : 3*i);
end

% Faces appearing once form the boundary of the (modified) volume mesh.
[u, ~, ic] = unique(facetags, 'stable');
counts = accumarray(ic, 1);
bnd_face_tags = u(counts == 1);

% Drop the faces that lie on the cube boundary.
bnd = gmsh.model.getBoundary([3, cube], true, false);
for k = 1:size(bnd, 1)
    fn = gmsh.model.mesh.getElementFaceNodes(TRI, 3, bnd(k, 2));
    [ftags, ~] = gmsh.model.mesh.getFaces(3, fn);
    bnd_face_tags = setdiff(bnd_face_tags, ftags, 'stable');
end

% Create a discrete surface for the cavity boundary.
news = gmsh.model.addDiscreteEntity(2);
nn = [];
for k = 1:numel(bnd_face_tags)
    nn = [nn, facemap(bnd_face_tags(k))]; %#ok<AGROW>
end
gmsh.model.mesh.addElementsByType(news, TRI, [], nn);

gmsh.model.mesh.reclassifyNodes();

newv = gmsh.model.addDiscreteEntity(3, -1, [news]);
gmsh.model.mesh.createGeometry([3, newv]);

gmsh.option.setNumber('Mesh.MeshOnlyEmpty', 1);
gmsh.model.mesh.generate(3);

gmsh.finalize();
