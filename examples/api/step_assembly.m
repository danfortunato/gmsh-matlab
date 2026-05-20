gmsh.initialize();

here = fileparts(mfilename('fullpath'));
gmsh.open(fullfile(here, 'as1-tu-203.stp'));

gmsh.option.setNumber('Mesh.MeshSizeFromCurvature', 15);
gmsh.option.setNumber('Mesh.MeshSizeMax', 8);

ent = gmsh.model.getEntities();
physicals = containers.Map('KeyType', 'char', 'ValueType', 'any');

for k = 1:size(ent, 1)
    dim = ent(k, 1);
    tag = ent(k, 2);
    n = gmsh.model.getEntityName(dim, tag);
    if ~isempty(n)
        fprintf('Entity (%d, %d) has label %s (and mass %g)\n', ...
            dim, tag, n, gmsh.model.occ.getMass(dim, tag));
        parts = strsplit(n, '/');
        if dim == 3 && numel(parts) > 3
            key = parts{3};
            if isKey(physicals, key)
                physicals(key) = [physicals(key), tag];
            else
                physicals(key) = tag;
            end
        end
    end
end

names = keys(physicals);
for k = 1:numel(names)
    p = gmsh.model.addPhysicalGroup(3, physicals(names{k}));
    gmsh.model.setPhysicalName(3, p, names{k});
end

gmsh.finalize();
