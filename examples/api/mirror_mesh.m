% Show how a mesh can be transformed (here, mirrored) and the transformed
% copy appended to the original mesh to get an overall conforming mesh.

gmsh.initialize();

gmsh.model.occ.addRectangle(0, 0, 0, 1, 0.5);
gmsh.model.occ.synchronize();
gmsh.model.mesh.setSize(gmsh.model.getEntities(0), 0.1);
gmsh.model.mesh.setSize([0, 2], 0.01);
gmsh.model.mesh.generate(3);

% Snapshot the mesh per entity.
ents = gmsh.model.getEntities();
nE = size(ents, 1);
snap = cell(1, nE);   % {bnd, nodes, elems}
for k = 1:nE
    d = ents(k, 1); t = ents(k, 2);
    bnd_k = gmsh.model.getBoundary(ents(k, :));
    [nt, nc, np] = gmsh.model.mesh.getNodes(d, t);
    [et, etgs, ent_] = gmsh.model.mesh.getElements(d, t);
    snap{k} = {bnd_k, {nt, nc, np}, {et, etgs, ent_}};
end

transform_mesh(ents, snap, 1000, 1000000, 1000000, -1,  1,  1);
transform_mesh(ents, snap, 2000, 2000000, 2000000,  1, -1,  1);
transform_mesh(ents, snap, 3000, 3000000, 3000000, -1, -1,  1);

gmsh.model.mesh.removeDuplicateNodes();
gmsh.finalize();


function transform_mesh(ents, snap, offset_entity, offset_node, offset_element, tx, ty, tz)
    nE = size(ents, 1);
    for k = 1:nE
        d = ents(k, 1); t = ents(k, 2);
        bnd = snap{k}{1};
        % Boundary tags with sign reflecting orientation, shifted by offset_entity.
        bnd_sig = zeros(0, 1);
        for b = 1:size(bnd, 1)
            sgn = sign(bnd(b, 2));
            bnd_sig(end+1) = (abs(bnd(b, 2)) + offset_entity) * sgn; %#ok<AGROW>
        end
        gmsh.model.addDiscreteEntity(d, t + offset_entity, bnd_sig.');
        coord = double(snap{k}{2}{2});
        coord(1:3:end) = coord(1:3:end) * tx;
        coord(2:3:end) = coord(2:3:end) * ty;
        coord(3:3:end) = coord(3:3:end) * tz;
        gmsh.model.mesh.addNodes(d, t + offset_entity, ...
            snap{k}{2}{1} + offset_node, coord);
        eTypes   = snap{k}{3}{1};
        eTags    = snap{k}{3}{2};
        eNodeTags = snap{k}{3}{3};
        eTagsShifted     = cell(size(eTags));
        eNodeTagsShifted = cell(size(eNodeTags));
        for j = 1:numel(eTags)
            eTagsShifted{j}     = eTags{j}     + offset_element;
            eNodeTagsShifted{j} = eNodeTags{j} + offset_node;
        end
        gmsh.model.mesh.addElements(d, t + offset_entity, ...
            eTypes, eTagsShifted, eNodeTagsShifted);
        if (tx * ty * tz) < 0
            gmsh.model.mesh.reverse([d, t + offset_entity]);
        end
    end
end
