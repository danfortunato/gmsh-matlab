function flatten(filename)
%FLATTEN  Port of flatten.py: read mesh, zero each node's z coord, rewrite.
%   Demonstrates the round-trip getNodes/getElements -> clear -> addNodes /
%   addElements approach (overkill for this use case; see flatten2.m).
%   Without an argument, prints a usage hint and returns.
    if nargin < 1
        fprintf('Usage: flatten(''path/to/mesh.msh'')\n');
        return
    end
    gmsh.initialize();
    try
        gmsh.open(filename);
    catch
        gmsh.finalize();
        return
    end

    entities = gmsh.model.getEntities();
    nE = size(entities, 1);
    nodeTags        = cell(1, nE);
    nodeCoords      = cell(1, nE);
    elementTypes    = cell(1, nE);
    elementTags     = cell(1, nE);
    elementNodeTags = cell(1, nE);
    for k = 1:nE
        d = entities(k, 1); t = entities(k, 2);
        [nodeTags{k}, nodeCoords{k}, ~]               = gmsh.model.mesh.getNodes(d, t);
        [elementTypes{k}, elementTags{k}, elementNodeTags{k}] = gmsh.model.mesh.getElements(d, t);
    end

    gmsh.model.mesh.clear();

    for k = 1:nE
        d = entities(k, 1); t = entities(k, 2);
        coords = double(nodeCoords{k});
        coords(3:3:end) = 0;
        gmsh.model.mesh.addNodes(d, t, nodeTags{k}, coords);
        gmsh.model.mesh.addElements(d, t, ...
            elementTypes{k}, elementTags{k}, elementNodeTags{k});
    end

    gmsh.finalize();
end
