gmsh.initialize();

% Initial geometry + mesh.
gmsh.model.add('house1');
add_house(10, 8, 5);
gmsh.model.mesh.generate(2);

% Store the mesh, keyed by (dim, tag).
ents = gmsh.model.getEntities();
nE = size(ents, 1);
mesh_nodes = cell(1, nE);
mesh_elems = cell(1, nE);
for k = 1:nE
    d = ents(k, 1); t = ents(k, 2);
    [nodeTags, coord, paramCoord]      = gmsh.model.mesh.getNodes(d, t);
    [eTypes, eTags, eNodeTags]         = gmsh.model.mesh.getElements(d, t);
    mesh_nodes{k} = {nodeTags, coord, paramCoord};
    mesh_elems{k} = {eTypes, eTags, eNodeTags};
end

% Perturbed geometry.
gmsh.model.add('house2');
add_house(9.5, 8.2, 5.1);

% Copy the old mesh into the perturbed geometry.
for k = 1:nE
    d = ents(k, 1); t = ents(k, 2);
    gmsh.model.mesh.addNodes(d, t, mesh_nodes{k}{1}, mesh_nodes{k}{2}, mesh_nodes{k}{3});
    gmsh.model.mesh.addElements(d, t, mesh_elems{k}{1}, mesh_elems{k}{2}, mesh_elems{k}{3});
end

% Relocate mesh nodes onto the perturbed geometry using the parametric coords.
gmsh.model.mesh.relocateNodes();

gmsh.finalize();


function add_house(A, B, C)
    p1 = gmsh.model.occ.addPoint(0,   0,     0);
    p2 = gmsh.model.occ.addPoint(A,   0,     0);
    p3 = gmsh.model.occ.addPoint(A,   B,     0);
    p4 = gmsh.model.occ.addPoint(A/2, B + C, 0);
    p5 = gmsh.model.occ.addPoint(0,   B,     0);
    l1 = gmsh.model.occ.addLine(p1, p2);
    l2 = gmsh.model.occ.addLine(p2, p3);
    l3 = gmsh.model.occ.addLine(p3, p4);
    l4 = gmsh.model.occ.addLine(p4, p5);
    l5 = gmsh.model.occ.addLine(p5, p1);
    cl = gmsh.model.occ.addCurveLoop([l1, l2, l3, l4, l5]);
    gmsh.model.occ.addSurfaceFilling(cl);
    gmsh.model.occ.synchronize();
end
