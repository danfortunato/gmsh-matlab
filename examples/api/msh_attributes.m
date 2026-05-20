gmsh.initialize();
gmsh.model.occ.addBox(0,0,0,1,1,1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate();
gmsh.model.setAttribute('Comments', { ...
    'Hello this is my comment on the block model', ...
    '... and a second comment'});
gmsh.write('block_with_attribute.msh');
gmsh.finalize();

gmsh.initialize();
gmsh.open('block_with_attribute.msh');
names = gmsh.model.getAttributeNames();
for i = 1:numel(names)
    attr = names{i};
    val = gmsh.model.getAttribute(attr);
    parts = strjoin(val, ''', ''');
    fprintf("Attribute %s =  ['%s']\n", attr, parts);
end
gmsh.finalize();
