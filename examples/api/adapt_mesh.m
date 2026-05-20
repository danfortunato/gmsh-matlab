function adapt_mesh(varargin)
%ADAPT_MESH  Port of adapt_mesh.py: solution-adaptive mesh refinement.
%   Optional positional args: initial lc, target #elements, dump-files flag.
    p = inputParser;
    addOptional(p, 'lc',        0.02,  @(x) isnumeric(x) && isscalar(x));
    addOptional(p, 'N',         10000, @(x) isnumeric(x) && isscalar(x));
    addOptional(p, 'dumpfiles', false, @islogical);
    parse(p, varargin{:});
    lc = p.Results.lc;
    N  = p.Results.N;
    dumpfiles = p.Results.dumpfiles;

    gmsh.initialize();

    gmsh.model.add("square");
    square = gmsh.model.occ.addRectangle(0, 0, 0, 1, 1);
    gmsh.model.occ.synchronize();

    pnts = gmsh.model.getBoundary([2, square], true, true, true);
    gmsh.model.mesh.setSize(pnts, lc);
    gmsh.model.mesh.generate(2);
    if dumpfiles, gmsh.write("mesh.msh"); end
    mesh = snapshot_mesh();

    [f_nod, err_ele] = compute_interpolation_error(mesh.vxyz, mesh.triangles);
    f_view = gmsh.view.add("nodal function");
    gmsh.view.addModelData(f_view, 0, "square", "NodeData", ...
        mesh.vtags, num2cell(f_nod(:)));
    if dumpfiles, gmsh.view.write(f_view, "f.pos"); end
    err_view = gmsh.view.add("element-wise error");
    gmsh.view.addModelData(err_view, 0, "square", "ElementData", ...
        mesh.triangles_tags, num2cell(err_ele(:)));
    if dumpfiles, gmsh.view.write(err_view, "err.pos"); end

    sf_ele = compute_size_field(mesh.vxyz, mesh.triangles, err_ele, N);
    sf_view = gmsh.view.add("mesh size field");
    gmsh.view.addModelData(sf_view, 0, "square", "ElementData", ...
        mesh.triangles_tags, num2cell(sf_ele(:)));
    gmsh.plugin.setNumber("Smooth", "View", gmsh.view.getIndex(sf_view));
    gmsh.plugin.run("Smooth");
    if dumpfiles, gmsh.view.write(sf_view, "sf.pos"); end

    gmsh.model.add("square2");
    gmsh.model.occ.addRectangle(0, 0, 0, 1, 1);
    gmsh.model.occ.synchronize();

    bg_field = gmsh.model.mesh.field.add("PostView");
    gmsh.model.mesh.field.setNumber(bg_field, "ViewTag", sf_view);
    gmsh.model.mesh.field.setAsBackgroundMesh(bg_field);
    gmsh.model.mesh.generate(2);
    if dumpfiles, gmsh.write("mesh2.msh"); end
    mesh2 = snapshot_mesh();

    [f2_nod, err2_ele] = compute_interpolation_error(mesh2.vxyz, mesh2.triangles);
    f2_view = gmsh.view.add("nodal function on adapted mesh");
    gmsh.view.addModelData(f2_view, 0, "square2", "NodeData", ...
        mesh2.vtags, num2cell(f2_nod(:)));
    if dumpfiles, gmsh.view.write(f2_view, "f2.pos"); end
    err2_view = gmsh.view.add("element-wise error on adapted mesh");
    gmsh.view.addModelData(err2_view, 0, "square2", "ElementData", ...
        mesh2.triangles_tags, num2cell(err2_ele(:)));
    if dumpfiles, gmsh.view.write(err2_view, "err2.pos"); end

    gmsh.finalize();
end


function m = snapshot_mesh()
    [vtags, vxyz, ~]      = gmsh.model.mesh.getNodes();
    [tri_tags, evtags]    = gmsh.model.mesh.getElementsByType(2);
    vxyz = reshape(double(vxyz), 3, []).';
    vtags = double(vtags);
    [~, vmap] = ismember(double(evtags), vtags);
    triangles = reshape(vmap, 3, []).';   % rows of node indices into vxyz
    m.vtags = vtags;
    m.vxyz  = vxyz;
    m.triangles_tags = tri_tags;
    m.triangles = triangles;
end


function f = my_function(xyz)
    a = 6 * (hypot(xyz(:, 1) - 0.5, xyz(:, 2) - 0.5) - 0.2);
    f = real(atanh(complex(a)));
end


function [f_vert, err_tri] = compute_interpolation_error(nodes, triangles)
    [uvw, weights] = gmsh.model.mesh.getIntegrationPoints(2, "Gauss2");
    weights = double(weights(:));
    [jac, det_, pt] = gmsh.model.mesh.getJacobians(2, uvw); %#ok<ASGLU>
    [~, sf, ~]      = gmsh.model.mesh.getBasisFunctions(2, uvw, "Lagrange");
    nQ = numel(weights);
    sf = reshape(double(sf), nQ, []);    % nQ x nNodesPerEl
    nT = size(triangles, 1);
    qx = reshape(double(pt), 3, nQ, nT);                % 3 x nQ x nT
    qx = permute(qx, [3, 2, 1]);                        % nT x nQ x 3
    det_ = abs(reshape(double(det_), nQ, nT)).';        % nT x nQ
    f_vert = my_function(nodes);                        % nV x 1
    f_at_nodes = f_vert(triangles);                     % nT x nNodesPerEl
    f_fem = f_at_nodes * sf.';                          % nT x nQ
    qx_flat = reshape(qx, [], 3);
    f_exact = reshape(my_function(qx_flat), nT, nQ);    % nT x nQ
    err_tri = sqrt(sum((f_fem - f_exact).^2 .* det_ .* weights.', 2));
end


function sf = compute_size_field(nodes, triangles, err, N)
    x = nodes(triangles(:, 1), :);   % proxy (not used beyond max-edge)
    a = 2.;
    d = 2.;
    fact = (a^((2 + a)/(1 + a)) + a^(1/(1 + a))) * sum(err.^(2/(1 + a)));
    ri = err.^(2/(2*(1 + a))) * a^(1/(d*(1 + a))) * ((1 + a) * N / fact)^(1/d);
    sf = triangle_max_edge(nodes, triangles) ./ ri;
    sf = sf(:);                                          %#ok<NASGU>
    sf = sf;
end


function e = triangle_max_edge(nodes, triangles)
    n1 = nodes(triangles(:, 1), :);
    n2 = nodes(triangles(:, 2), :);
    n3 = nodes(triangles(:, 3), :);
    e = max(max(vecnorm(n1 - n2, 2, 2), vecnorm(n1 - n3, 2, 2)), ...
            vecnorm(n2 - n3, 2, 2));
end
