% Port of torus_bspline.py. The Python version builds ellipses and tori as
% rational NURBS surfaces through a small geometry helper layer
% (Q3D_Point / Q3D_Vector / Q3D_Frame / Q3D_NURBS_Data / Q3D_Draw). Here we
% capture the same workflow with structs and functions; nothing depends on
% MATLAB OO.

gmsh.initialize();
gmsh.model.add("torus");

% Shared expression-id counter (Python's Q3D_Draw.__counter).
global Q3D_COUNTER %#ok<GVMIS>
Q3D_COUNTER = 0;
mesh_default = 0.1;

C1 = test_ellipse('XY', [-1.0,  0.0,  0.0], 1.0, 1.0, mesh_default); %#ok<NASGU>
C2 = test_ellipse('YZ', [ 0.0, -1.0,  0.0], 0.8, 0.3, mesh_default); %#ok<NASGU>
C3 = test_ellipse('ZX', [ 0.0,  0.0, -1.0], 0.2, 0.9, mesh_default); %#ok<NASGU>

S1 = test_torus('XY', [ 1.0, 0.0, 0.0], 1,   0.2, 0.2, 0,   [], mesh_default); %#ok<NASGU>
S2 = test_torus('YZ', [ 0.5, 0.0, 1.0], 1,   0.2, 0.2, 0,   [-0.25*pi, 1.25*pi], mesh_default); %#ok<NASGU>
S3 = test_torus('ZX', [ 0.0, 0.0, 0.5], 0.6, 0.1, 0.3, 0.5, [ 0.25*pi, 4.25*pi], mesh_default); %#ok<NASGU>

gmsh.model.mesh.generate(2);
gmsh.finalize();


% ---------- top-level driver helpers ----------

function out = test_ellipse(orientation, origin, major, minor, mesh_default)
    frame = sketch_reset(orientation, origin);
    data  = nurbs_ellipse(frame, major, minor, 1.0);
    out   = draw_nurbs(['ellipse-', orientation], data, mesh_default);
end

function out = test_torus(orientation, origin, radius, major, minor, pitch, theta, mesh_default)
    frame = sketch_reset(orientation, origin);
    data  = nurbs_torus(frame, radius, major, minor, pitch, theta);
    out   = draw_nurbs(['torus-', orientation], data, mesh_default);
end


% ---------- frame ----------

function f = sketch_reset(orientation, origin)
    f.O = origin;
    switch orientation
        case 'YX', f.e1 = [ 0,  1,  0]; f.e2 = [ 1,  0,  0]; f.e3 = [ 0,  0, -1];
        case 'YZ', f.e1 = [ 0,  1,  0]; f.e2 = [ 0,  0,  1]; f.e3 = [ 1,  0,  0];
        case 'ZY', f.e1 = [ 0,  0,  1]; f.e2 = [ 0,  1,  0]; f.e3 = [-1,  0,  0];
        case 'XZ', f.e1 = [ 1,  0,  0]; f.e2 = [ 0,  0,  1]; f.e3 = [ 0, -1,  0];
        case 'ZX', f.e1 = [ 0,  0,  1]; f.e2 = [ 1,  0,  0]; f.e3 = [ 0,  1,  0];
        otherwise, f.e1 = [ 1,  0,  0]; f.e2 = [ 0,  1,  0]; f.e3 = [ 0,  0,  1];
    end
end

function p = local_to_global(f, l123)
    p = f.O + l123(1)*f.e1 + l123(2)*f.e2 + l123(3)*f.e3;
end

function f = local_translate(f, l123)
    f.O = local_to_global(f, l123);
end

function f = e1_rotate(f, theta)
    c = cos(theta); s = sin(theta);
    b2 = unitvec(c*f.e2 +  s*f.e3);
    b3 = unitvec(c*f.e3 + -s*f.e2);
    f.e2 = b2;  f.e3 = b3;
end

function v = unitvec(v)
    v = v / norm(v);
end


% ---------- NURBS data builders ----------

function data = nurbs_ellipse(frame, major, minor, base_weight)
    [angles, cha, Ncp] = arc_angles([], true);
    [kts, mps]         = arc_kts_mps(Ncp, true);
    cps = cell(1, Ncp);
    wts = zeros(1, Ncp);
    ha = false;
    for k = 1:numel(angles)
        a = angles(k);
        if ha, rs = 1.0/cha; ha = false; else, rs = 1.0; ha = true; end
        cps{k} = local_to_global(frame, [rs*cos(a)*major, rs*sin(a)*minor, 0]);
        wts(k) = base_weight / rs;
    end
    data.deg = 2;
    data.kts = kts;
    data.mps = mps;
    data.cps = cps;
    data.wts = wts;
    data.per = true;
    data.is_surface = false;
end

function data = nurbs_torus(frame, radius, major, minor, pitch, theta)
    if pitch == 0 && ~isempty(theta) && abs(theta(2) - theta(1)) >= 2*pi
        theta = [];
    end
    per2 = (pitch == 0 && isempty(theta));
    [angles, cha, Ncp] = arc_angles(theta, per2);
    [kts2, mps2]       = arc_kts_mps(Ncp, per2);

    cps = cell(1, numel(angles));
    wts = cell(1, numel(angles));
    deg1 = []; kts1 = []; mps1 = []; per1 = [];
    ha = false;
    for k = 1:numel(angles)
        a = angles(k);
        if ha, rs = 1.0/cha; ha = false; else, rs = 1.0; ha = true; end
        ff = frame;
        ff = e1_rotate(ff, a);
        ff = local_translate(ff, [pitch*a*0.5/pi, rs*radius, 0]);
        sub = nurbs_ellipse(ff, major, rs*minor, 1.0/rs);
        cps{k} = sub.cps;
        wts{k} = sub.wts;
        if isempty(deg1)
            deg1 = sub.deg; kts1 = sub.kts; mps1 = sub.mps; per1 = sub.per;
        end
    end
    data.deg = [deg1, 2];
    data.kts = {kts1, kts2};
    data.mps = {mps1, mps2};
    data.cps = cps;
    data.wts = wts;
    data.per = [per1, per2];
    data.is_surface = true;
end

function [angles, cha, Ncp] = arc_angles(theta, bPeriodic)
    if ~isempty(theta), t1 = theta(1); t2 = theta(2);
    else, t1 = 0; t2 = 2*pi; end
    Narc = ceil(abs(t2 - t1) * 1.5 / pi);
    cha = cos(abs(t2 - t1) * 0.5 / Narc);
    Ncp = 2 * Narc;
    angles = t1 + (t2 - t1) * (0:Ncp-1) / Ncp;
    if ~bPeriodic
        angles(end+1) = t2;
        Ncp = Ncp + 1;
    end
end

function [kts, mps] = arc_kts_mps(Ncp, bPeriodic)
    if bPeriodic, mps = 2; else, mps = 3; end
    kts = [];
    Narc = floor(Ncp / 2);
    for a = 0:Narc-1
        kts(end+1) = a / Narc; %#ok<AGROW>
        if a > 0
            mps(end+1) = 2; %#ok<AGROW>
        end
    end
    mps(end+1) = mps(1);
    kts(end+1) = 1;
end


% ---------- gmsh drawing ----------

function out = draw_nurbs(name, data, mesh_default)
    if data.is_surface
        out = draw_nurbs_surface(name, data, mesh_default);
    else
        out = draw_nurbs_curve(name, data, mesh_default);
    end
end

function id = new_id()
    global Q3D_COUNTER %#ok<GVMIS>
    Q3D_COUNTER = Q3D_COUNTER + 1;
    id = Q3D_COUNTER;
end

function id = draw_point(pt, mesh_default)
    id = new_id();
    gmsh.model.occ.addPoint(pt(1), pt(2), pt(3), mesh_default, id);
end

function id = draw_loop(segments)
    id = new_id();
    gmsh.model.occ.addCurveLoop(segments, id);
end

function id = pp_surface(name, loops)
    id = new_id();
    gmsh.model.occ.addPlaneSurface(loops, id);
    gmsh.model.occ.synchronize();
    m = new_id();
    gmsh.model.addPhysicalGroup(2, [id], m, name);
    id = m;
end

function out = draw_nurbs_curve(name, data, mesh_default)
    cps = zeros(1, numel(data.cps));
    wts = data.wts;
    for k = 1:numel(data.cps)
        cps(k) = draw_point(data.cps{k}, mesh_default);
    end
    if data.per
        cps(end+1) = cps(1);
        wts(end+1) = wts(1);
    end
    p = new_id();
    gmsh.model.occ.addBSpline(cps, p, data.deg, wts, data.kts, data.mps);
    if data.per
        p = draw_loop([p]);
        p = pp_surface(name, [p]);
    end
    out = p;
end

function out = draw_nurbs_surface(name, data, mesh_default)
    face_f = []; face_b = [];
    deg1 = data.deg(1); deg2 = data.deg(2);
    kts1 = data.kts{1}; kts2 = data.kts{2};
    mps1 = data.mps{1}; mps2 = data.mps{2};
    per1 = data.per(1); per2 = data.per(2);
    dim1 = numel(data.cps{1});
    dim2 = numel(data.cps);
    cps = [];
    wts = [];
    cp_wt_1st = [];
    for i2 = 1:dim2
        cpsf = []; wtsf = [];
        cp_list = data.cps{i2};
        wt_list = data.wts{i2};
        for i1 = 1:dim1
            cp_id = draw_point(cp_list{i1}, mesh_default);
            cps(end+1) = cp_id; %#ok<AGROW>
            wts(end+1) = wt_list(i1); %#ok<AGROW>
            if per1 && i1 == 1
                cp_wt_1st = [cp_id, wt_list(i1)];
            end
            if per1 && ~per2
                if i2 == 1 || i2 == dim2
                    cpsf(end+1) = cp_id; %#ok<AGROW>
                    wtsf(end+1) = wt_list(i1); %#ok<AGROW>
                end
            end
        end
        if per1
            cps(end+1) = cp_wt_1st(1); %#ok<AGROW>
            wts(end+1) = cp_wt_1st(2); %#ok<AGROW>
            if ~per2 && (i2 == 1 || i2 == dim2)
                cpsf(end+1) = cp_wt_1st(1);
                wtsf(end+1) = cp_wt_1st(2);
                p = new_id();
                gmsh.model.occ.addBSpline(cpsf, p, deg1, wtsf, kts1, mps1);
                if i2 == 1, face_f = draw_loop([p]);
                elseif i2 == dim2, face_b = draw_loop([p]); end
            end
        end
    end
    if per1, dim1 = dim1 + 1; end
    if per2
        for i1 = 1:dim1
            cps(end+1) = cps(i1); %#ok<AGROW>
            wts(end+1) = wts(i1); %#ok<AGROW>
        end
        dim2 = dim2 + 1; %#ok<NASGU>
    end
    p = new_id();
    gmsh.model.occ.addBSplineSurface(cps, dim1, p, deg1, deg2, wts, ...
        kts1, kts2, mps1, mps2);
    gmsh.model.occ.synchronize();
    m = new_id();
    gmsh.model.addPhysicalGroup(2, [p], m, name);
    if ~isempty(face_f), face_f = pp_surface([name, '-f'], [face_f]); end
    if ~isempty(face_b), face_b = pp_surface([name, '-b'], [face_b]); end
    out = [m, face_f, face_b];
end
