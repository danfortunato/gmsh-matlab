% -----------------------------------------------------------------------------
%
%  Gmsh MATLAB extended tutorial 1
%
%  Geometry and mesh data
%
% -----------------------------------------------------------------------------

gmsh.initialize();

% No CLI args to mimic the Python `len(sys.argv) > 1` branch; always create
% the cone geometry path.
gmsh.model.occ.addCone(1, 0, 0, 1, 0, 0, 0.5, 0.1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate();

% Model name and dimension:
fprintf('Model %s (%dD)\n', gmsh.model.getCurrent(), gmsh.model.getDimension());

entities = gmsh.model.getEntities();
for i = 1:size(entities, 1)
    e   = entities(i, :);
    dim = e(1);
    tag = e(2);

    [nodeTags, ~, ~]               = gmsh.model.mesh.getNodes(dim, tag);
    [elemTypes, elemTags, ~]       = gmsh.model.mesh.getElements(dim, tag);

    entityType = gmsh.model.getType(dim, tag);
    entityName = gmsh.model.getEntityName(dim, tag);
    if ~isempty(entityName), entityName = [entityName, ' ']; end %#ok<AGROW>
    fprintf('Entity %s(%d, %d) of type %s\n', ...
        entityName, dim, tag, entityType);

    numElem = sum(cellfun(@numel, elemTags));
    fprintf(' - Mesh has %d nodes and %d elements\n', numel(nodeTags), numElem);

    [up, down] = gmsh.model.getAdjacencies(dim, tag);
    if ~isempty(up)
        fprintf(' - Upward adjacencies: %s\n', mat2str(up));
    end
    if ~isempty(down)
        fprintf(' - Downward adjacencies: %s\n', mat2str(down));
    end

    physicalTags = gmsh.model.getPhysicalGroupsForEntity(dim, tag);
    if ~isempty(physicalTags)
        s = '';
        for p = physicalTags
            n = gmsh.model.getPhysicalName(dim, p);
            if ~isempty(n), n = [n, ' ']; end %#ok<AGROW>
            s = [s, sprintf('%s(%d, %d) ', n, dim, p)]; %#ok<AGROW>
        end
        fprintf(' - Physical groups: %s\n', s);
    end

    partitions = gmsh.model.getPartitions(dim, tag);
    if ~isempty(partitions)
        [parentDim, parentTag] = gmsh.model.getParent(dim, tag);
        fprintf(' - Partition tags: %s - parent entity (%d, %d)\n', ...
            mat2str(partitions), parentDim, parentTag);
    end

    for t = elemTypes
        [eName, ~, order, numv, parv, ~] = ...
            gmsh.model.mesh.getElementProperties(t);
        fprintf(' - Element type: %s, order %d (%d nodes in param coord: %s)\n', ...
            eName, order, numv, mat2str(parv));
    end
end

gmsh.clear();
gmsh.finalize();
