function stl_to_brep(filename)
%STL_TO_BREP  Port of stl_to_brep.py: STL triangulation -> BREP plane surfaces.
%   stl_to_brep(FILENAME) reads FILENAME, creates one plane surface per
%   triangle, and writes <basename>.brep.
    if nargin < 1
        fprintf('Usage: stl_to_brep(''path/to/file.stl'')\n');
        return
    end
    gmsh.initialize();
    try
        gmsh.open(filename);
    catch
        gmsh.finalize();
        return
    end

    typ = 2;   % 3-node triangles
    [elementTags, ~]    = gmsh.model.mesh.getElementsByType(typ);
    [nodeTags, nodeCoord, ~] = gmsh.model.mesh.getNodesByElementType(typ);
    edgeNodes           = gmsh.model.mesh.getElementEdgeNodes(typ);

    gmsh.model.add('my brep');

    % Geometrical points keyed by node tag.
    nodeCoord = double(nodeCoord);
    coords = reshape(nodeCoord, 3, []).';
    for k = 1:numel(nodeTags)
        gmsh.model.occ.addPoint(coords(k, 1), coords(k, 2), coords(k, 3), ...
            0., double(nodeTags(k)));
    end

    % Plane surface per triangle, sharing curves via a map keyed by sorted
    % endpoint pair.
    allsurfaces = [];
    edgeNodes = reshape(edgeNodes, 2, 3, []);   % (endpoint, edge, element)
    allcurves = containers.Map('KeyType', 'char', 'ValueType', 'double');
    nE = size(edgeNodes, 3);
    fprintf('... creating %d surfaces\n', nE);
    for e = 1:nE
        curves = zeros(1, 3);
        for j = 1:3
            edge = double(edgeNodes(:, j, e));
            edge_s = sort(edge);
            key = sprintf('%d,%d', edge_s(1), edge_s(2));
            if isKey(allcurves, key)
                t = allcurves(key);
            else
                t = gmsh.model.occ.addLine(edge(1), edge(2));
                allcurves(key) = t;
            end
            curves(j) = t;
        end
        cl = gmsh.model.occ.addCurveLoop(curves);
        allsurfaces(end+1) = gmsh.model.occ.addPlaneSurface([cl]); %#ok<AGROW>
    end

    gmsh.model.occ.synchronize();

    if ~isempty(allsurfaces)
        bnd = gmsh.model.getBoundary(gmsh.model.getEntities(2));
        if isempty(bnd)
            fprintf('... creating volume\n');
            sl = gmsh.model.occ.addSurfaceLoop(allsurfaces);
            gmsh.model.occ.addVolume([sl]);
        end
    end

    fprintf('... done!\n');

    [~, basename, ~] = fileparts(filename);
    gmsh.write([basename, '.brep']);

    gmsh.finalize();
end
