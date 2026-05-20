% Port of poisson.py: 2D Poisson equation -Delta u = f on a mixed-source
% domain, solved with a vectorized FE assembly using MATLAB sparse matrices.

DEBUG = 0; RECOMBINE = 0; %#ok<NASGU>

gmsh.initialize();
create_geometry();

if RECOMBINE
    gmsh.model.mesh.setRecombine(2, 2);
    gmsh.model.mesh.setRecombine(2, 3);
    gmsh.model.mesh.setRecombine(2, 4);
end

gmsh.model.mesh.generate(2);

if DEBUG, gmsh.write('poisson.msh'); end

fem_solve();

gmsh.option.setNumber("View[0].IntervalsType", 3);
gmsh.option.setNumber("View[0].NbIso", 20);
gmsh.finalize();


function create_geometry()
    gmsh.model.add("poisson");
    s1 = gmsh.model.occ.addRectangle(0, 0, 0, 1, 1);
    s2 = gmsh.model.occ.addDisk(0.7, 0.5, 0, 0.1, 0.1);
    s3 = gmsh.model.occ.addRectangle(0.2, 0.4, 0, 0.2, 0.2);
    surf = [2, s1; 2, s2; 2, s3];
    [surf, ~] = gmsh.model.occ.fragment(surf, zeros(0, 2));
    gmsh.model.occ.synchronize();

    bnd = gmsh.model.getBoundary(surf, true, false);

    gmsh.model.addPhysicalGroup(2, [surf(1, 2)], 2);
    gmsh.model.setPhysicalName(2, 2, 'SourceCircle');
    gmsh.model.addPhysicalGroup(2, [surf(2, 2)], 3);
    gmsh.model.setPhysicalName(2, 3, 'SourceSquare');
    gmsh.model.addPhysicalGroup(2, [surf(3, 2)], 4);
    gmsh.model.setPhysicalName(2, 4, 'Domain');
    gmsh.model.addPhysicalGroup(1, bnd(:, 2).', 11);
    gmsh.model.setPhysicalName(1, 11, 'Boundary');

    gmsh.model.mesh.setSize(gmsh.model.getEntities(0), 0.1);
end


function fem_solve()
    [mshNodes, ~, ~] = gmsh.model.mesh.getNodes();
    mshNodes = double(mshNodes);
    numMeshNodes = numel(mshNodes);
    maxNodeTag   = max(mshNodes);

    typNodes = zeros(maxNodeTag + 1, 1);
    typNodes(mshNodes + 1) = 1;

    matrow = []; matcol = []; matval = [];
    rhsrow = []; rhsval = [];

    groups = gmsh.model.getPhysicalGroups();
    for ig = 1:size(groups, 1)
        dimGroup = groups(ig, 1); tagGroup = groups(ig, 2);
        namGroup = gmsh.model.getPhysicalName(dimGroup, tagGroup);
        ents = gmsh.model.getEntitiesForPhysicalGroup(dimGroup, tagGroup);
        for tagEntity = double(ents)
            etypes = gmsh.model.mesh.getElementTypes(dimGroup, tagEntity);
            for elementType = etypes
                [vTags, vNodes] = gmsh.model.mesh.getElementsByType( ...
                    elementType, tagEntity);
                numElements = numel(vTags);
                vNodes = double(vNodes);
                enode = reshape(vNodes, [], numElements).';     % e x n
                numElementNodes = size(enode, 2);

                if dimGroup == 2
                    [~, ~, order, ~, ~, ~] = ...
                        gmsh.model.mesh.getElementProperties(elementType);
                    [uvw, weights] = gmsh.model.mesh.getIntegrationPoints( ...
                        elementType, sprintf('Gauss%d', 2 * order));
                    [~, sf, ~]    = gmsh.model.mesh.getBasisFunctions( ...
                        elementType, uvw, 'Lagrange');
                    [~, dsfdu, ~] = gmsh.model.mesh.getBasisFunctions( ...
                        elementType, uvw, 'GradLagrange');
                    weights = double(weights(:));
                    nG = numel(weights);
                    sf    = reshape(double(sf),    nG, numElementNodes);
                    dsfdu = reshape(double(dsfdu), nG, numElementNodes, 3);
                    dsfdu = dsfdu(:, :, 1:2);   % drop dw component

                    [qjac, qdet, ~] = gmsh.model.mesh.getJacobians( ...
                        elementType, uvw, tagEntity);
                    qdet = abs(reshape(double(qdet), nG, numElements));   % g x e
                    dxdu_all = reshape(double(qjac), 3, 3, nG, numElements);
                    % Per-(elem, gauss) 2x2 jacobian (drop 3rd row/col).
                    dxdu = dxdu_all(1:2, 1:2, :, :);

                    localmat = zeros(numElements, numElementNodes, numElementNodes);
                    for e = 1:numElements
                        for g = 1:nG
                            J = dxdu(:, :, g, e);
                            Jinv = inv(J);
                            dsfdx = squeeze(dsfdu(g, :, :)) * Jinv;   % n x 2
                            localmat(e, :, :) = squeeze(localmat(e, :, :)) + ...
                                (dsfdx * dsfdx.') * qdet(g, e) * weights(g);
                        end
                    end

                    % Replicate node indices for COO assembly.
                    col = repmat(enode, [1, 1, numElementNodes]);            % e x n x n
                    row = permute(col, [1, 3, 2]);
                    matcol = [matcol; col(:)]; %#ok<AGROW>
                    matrow = [matrow; row(:)]; %#ok<AGROW>
                    matval = [matval; localmat(:)]; %#ok<AGROW>

                    if strcmp(namGroup, 'SourceCircle') || strcmp(namGroup, 'SourceSquare')
                        load = -1; if strcmp(namGroup, 'SourceSquare'), load = 1; end
                        localrhs = zeros(numElements, numElementNodes);
                        for e = 1:numElements
                            for g = 1:nG
                                localrhs(e, :) = localrhs(e, :) + ...
                                    load * sf(g, :) * qdet(g, e) * weights(g);
                            end
                        end
                        rhsrow = [rhsrow; enode(:)]; %#ok<AGROW>
                        rhsval = [rhsval; localrhs(:)]; %#ok<AGROW>
                    end
                end

                if strcmp(namGroup, 'Boundary')
                    typNodes(vNodes + 1) = 2;
                end
            end
        end
    end

    % Renumber: internal first, boundary last.
    node2unknown = zeros(maxNodeTag + 1, 1);
    index = 0;
    for k = 1:numel(typNodes)
        if typNodes(k) == 1
            index = index + 1;
            node2unknown(k) = index;
        end
    end
    numUnknowns = index;
    for k = 1:numel(typNodes)
        if typNodes(k) == 2
            index = index + 1;
            node2unknown(k) = index;
        end
    end
    unknown2node = zeros(numMeshNodes + 1, 1);
    for node = 1:numel(node2unknown)
        u = node2unknown(node);
        if u > 0, unknown2node(u + 1) = node - 1; end
    end

    rows = node2unknown(matcol + 1);
    cols = node2unknown(matrow + 1);
    globalmat = sparse(rows, cols, matval, numMeshNodes, numMeshNodes);

    globalrhs = zeros(numMeshNodes, 1);
    for i = 1:numel(rhsrow)
        idx = node2unknown(rhsrow(i) + 1);
        globalrhs(idx) = globalrhs(idx) + rhsval(i);
    end

    sol = globalmat(1:numUnknowns, 1:numUnknowns) \ globalrhs(1:numUnknowns);
    sol = [sol; zeros(numMeshNodes - numUnknowns, 1)];

    sview = gmsh.view.add("solution");
    gmsh.view.addModelData(sview, 0, "", "NodeData", ...
        unknown2node(2:end), num2cell(sol(:)));
end
