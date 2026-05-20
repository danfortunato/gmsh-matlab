function explore(filename)
%EXPLORE  Port of explore.py: print model + mesh details for the given file.
%   Without an argument, prints a usage hint and returns.
    if nargin < 1
        fprintf('Usage: explore(''path/to/mesh.msh'')\n');
        return
    end
    gmsh.initialize();
    try
        gmsh.open(filename);
    catch
        gmsh.finalize();
        return
    end

    fprintf('Model name: %s\n', gmsh.model.getCurrent());

    entities = gmsh.model.getEntities();
    for k = 1:size(entities, 1)
        dim = entities(k, 1);
        tag = entities(k, 2);
        fprintf('Entity (%d, %d) of type %s\n', ...
            dim, tag, gmsh.model.getType(dim, tag));

        [nodeTags, ~, ~]         = gmsh.model.mesh.getNodes(dim, tag);
        [elemTypes, elemTags, ~] = gmsh.model.mesh.getElements(dim, tag);
        numElem = sum(cellfun(@numel, elemTags));
        fprintf(' - mesh has %d nodes and %d elements\n', ...
            numel(nodeTags), numElem);

        boundary = gmsh.model.getBoundary(entities(k, :));
        fprintf(' - boundary entities (%d, 2)\n', size(boundary, 1));

        partitions = gmsh.model.getPartitions(dim, tag);
        if ~isempty(partitions)
            [parentDim, parentTag] = gmsh.model.getParent(dim, tag);
            fprintf(' - Partition tag(s): %s - parent entity (%d, %d)\n', ...
                mat2str(partitions), parentDim, parentTag);
        end
        for t = elemTypes
            [eName, ~, order, numv, parv, ~] = ...
                gmsh.model.mesh.getElementProperties(t);
            fprintf(' - Element type: %s, order %d (%d nodes in param coord: %s)\n', ...
                eName, order, numv, mat2str(parv));
        end
    end

    [~, ~, ~] = gmsh.model.mesh.getNodes();
    gmsh.finalize();
end
