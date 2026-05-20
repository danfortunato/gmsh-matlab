% Compute neighbours (by a face) of all tetrahedra in the mesh.
gmsh.initialize();

gmsh.model.add("my test model");
gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate(3);

disp("--- getting tets and face nodes");
[tets, ~] = gmsh.model.mesh.getElementsByType(4);
fnodes = gmsh.model.mesh.getElementFaceNodes(4, 3);

disp("--- computing face x tet incidence");
nfaces = numel(fnodes) / 3;
faces  = cell(1, nfaces);
fxt    = containers.Map('KeyType', 'char', 'ValueType', 'any');
for i = 1:nfaces
    f = sort(fnodes(3*(i-1)+1 : 3*i));
    faces{i} = f;
    key = sprintf('%llu,%llu,%llu', f(1), f(2), f(3));
    t = tets(floor((i - 1) / 4) + 1);
    if isKey(fxt, key)
        fxt(key) = [fxt(key), t];
    else
        fxt(key) = t;
    end
end

disp("--- computing neighbors by face");
txt = containers.Map('KeyType', 'uint64', 'ValueType', 'any');
for i = 1:nfaces
    f = faces{i};
    key = sprintf('%llu,%llu,%llu', f(1), f(2), f(3));
    t = tets(floor((i - 1) / 4) + 1);
    if ~isKey(txt, t), txt(t) = uint64([]); end
    for tt = fxt(key)
        if tt ~= t && ~any(txt(t) == tt)
            txt(t) = [txt(t), tt];
        end
    end
end

fprintf('--- done: %d tets, neighbors computed\n', numel(tets));
gmsh.finalize();
