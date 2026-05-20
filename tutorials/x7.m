% -----------------------------------------------------------------------------
%
%  Gmsh MATLAB extended tutorial 7
%
%  Additional mesh data: internal edges and faces
%
% -----------------------------------------------------------------------------

gmsh.initialize();

gmsh.model.add("x7");

% Simple cube mesh.
gmsh.model.occ.addBox(0, 0, 0, 1, 1, 1);
gmsh.model.occ.synchronize();
gmsh.option.setNumber("Mesh.MeshSizeMin", 2.);
gmsh.model.mesh.generate(3);

% Element edges and faces for first-order tetrahedra.
elementType = gmsh.model.mesh.getElementType("tetrahedron", 1);
edgeNodes   = gmsh.model.mesh.getElementEdgeNodes(elementType);
faceNodes   = gmsh.model.mesh.getElementFaceNodes(elementType, 3);

% Materialise unique edge and face tags.
gmsh.model.mesh.createEdges();
gmsh.model.mesh.createFaces();

[edgeTags, ~] = gmsh.model.mesh.getEdges(edgeNodes);
[faceTags, ~] = gmsh.model.mesh.getFaces(3, faceNodes);

[elementTags, ~] = gmsh.model.mesh.getElementsByType(elementType);

% Build edge -> [elements] and face -> [elements] maps. MATLAB has no native
% dict; use containers.Map keyed by uint64.
edges2Elements = containers.Map('KeyType', 'uint64', 'ValueType', 'any');
faces2Elements = containers.Map('KeyType', 'uint64', 'ValueType', 'any');

for i = 1:numel(edgeTags) % 6 edges per tetrahedron
    et = edgeTags(i);
    el = elementTags(floor((i - 1) / 6) + 1);
    if isKey(edges2Elements, et)
        edges2Elements(et) = [edges2Elements(et), el];
    else
        edges2Elements(et) = el;
    end
end
for i = 1:numel(faceTags) % 4 faces per tetrahedron
    ft = faceTags(i);
    el = elementTags(floor((i - 1) / 4) + 1);
    if isKey(faces2Elements, ft)
        faces2Elements(ft) = [faces2Elements(ft), el];
    else
        faces2Elements(ft) = el;
    end
end

% Create a new discrete surface and fill it with one triangle per unique face.
s = gmsh.model.addDiscreteEntity(2);

maxElementTag = gmsh.model.mesh.getMaxElementTag();
uniqueFaceTags        = containers.Map('KeyType', 'uint64', 'ValueType', 'logical');
tagsForTriangles      = uint64([]);
faceNodesForTriangles = uint64([]);
for i = 1:numel(faceTags)
    ft = faceTags(i);
    if ~isKey(uniqueFaceTags, ft)
        uniqueFaceTags(ft) = true;
        tagsForTriangles(end+1) = ft + maxElementTag; %#ok<AGROW>
        faceNodesForTriangles(end+1) = faceNodes(3*(i-1) + 1); %#ok<AGROW>
        faceNodesForTriangles(end+1) = faceNodes(3*(i-1) + 2); %#ok<AGROW>
        faceNodesForTriangles(end+1) = faceNodes(3*(i-1) + 3); %#ok<AGROW>
    end
end
elementType2D = gmsh.model.mesh.getElementType("triangle", 1);
gmsh.model.mesh.addElementsByType(s, elementType2D, ...
    tagsForTriangles, faceNodesForTriangles);

for t = tagsForTriangles
    fprintf('triangle %d is connected to tetrahedra %s\n', ...
        t, mat2str(faces2Elements(t - maxElementTag)));
end

% Also retrieve all edges and faces directly.
[~, ~] = gmsh.model.mesh.getAllEdges();
[~, ~] = gmsh.model.mesh.getAllFaces(3);

gmsh.finalize();
