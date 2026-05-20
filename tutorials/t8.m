% ------------------------------------------------------------------------------
%
%  Gmsh MATLAB tutorial 8
%
%  Post-processing, image export and animations
%
% ------------------------------------------------------------------------------
%
% NOTE: this tutorial drives the FLTK GUI to render frames. On macOS, FLTK
% expects to own the main Cocoa thread, which MATLAB already owns, so the
% GUI calls will not behave correctly when run from inside MATLAB. The port
% is provided for parity with the Python tutorial; recommended use is to
% launch the standalone `gmsh` binary on the produced model instead.

gmsh.initialize();

% Simple rectangular geometry.
lc = 1e-2;
gmsh.model.geo.addPoint(0,   0,   0, lc, 1);
gmsh.model.geo.addPoint(0.1, 0,   0, lc, 2);
gmsh.model.geo.addPoint(0.1, 0.3, 0, lc, 3);
gmsh.model.geo.addPoint(0,   0.3, 0, lc, 4);
gmsh.model.geo.addLine(1, 2, 1);
gmsh.model.geo.addLine(3, 2, 2);
gmsh.model.geo.addLine(3, 4, 3);
gmsh.model.geo.addLine(4, 1, 4);
gmsh.model.geo.addCurveLoop([4, 1, -2, 3], 1);
gmsh.model.geo.addPlaneSurface([1], 1);

gmsh.model.geo.synchronize();

% Merge example post-processing views shipped with gmsh.
here = fileparts(mfilename('fullpath'));
gmsh.merge(fullfile(here, 'view1.pos'));
gmsh.merge(fullfile(here, 'view1.pos'));
gmsh.merge(fullfile(here, 'view4.pos'));

% General display options.
gmsh.option.setNumber("General.Trackball", 0);
gmsh.option.setNumber("General.RotationX", 0);
gmsh.option.setNumber("General.RotationY", 0);
gmsh.option.setNumber("General.RotationZ", 0);

gmsh.option.setColor("General.Background", 255, 255, 255);
gmsh.option.setColor("General.Foreground", 0,   0,   0);
gmsh.option.setColor("General.Text",       0,   0,   0);

gmsh.option.setNumber("General.Orthographic", 0);
gmsh.option.setNumber("General.Axes",         0);
gmsh.option.setNumber("General.SmallAxes",    0);

% gmsh.fltk.initialize();  % see note above

v = gmsh.view.getTags();
if numel(v) ~= 4
    gmsh.logger.write("Wrong number of views!", "error");
    gmsh.finalize();
    return
end

% Per-view options.
gmsh.view.option.setNumber(v(1), "IntervalsType", 2);
gmsh.view.option.setNumber(v(1), "OffsetZ", 0.05);
gmsh.view.option.setNumber(v(1), "RaiseZ", 0);
gmsh.view.option.setNumber(v(1), "Light", 1);
gmsh.view.option.setNumber(v(1), "ShowScale", 0);
gmsh.view.option.setNumber(v(1), "SmoothNormals", 1);

gmsh.view.option.setNumber(v(2), "IntervalsType", 1);
gmsh.view.option.setNumber(v(2), "NbIso", 10);
gmsh.view.option.setNumber(v(2), "ShowScale", 0);

gmsh.view.option.setString(v(3), "Name", "Test...");
gmsh.view.option.setNumber(v(3), "Axes", 1);
gmsh.view.option.setNumber(v(3), "IntervalsType", 2);
gmsh.view.option.setNumber(v(3), "Type", 2);
gmsh.view.option.setNumber(v(3), "AutoPosition", 0);
gmsh.view.option.setNumber(v(3), "PositionX", 85);
gmsh.view.option.setNumber(v(3), "PositionY", 50);
gmsh.view.option.setNumber(v(3), "Width", 200);
gmsh.view.option.setNumber(v(3), "Height", 130);

gmsh.view.option.setNumber(v(4), "Visible", 0);

% Animation loop. Without a graphics context (FLTK not initialised), the
% gmsh.graphics.draw() calls are no-ops; we still exercise the option-set
% paths for parity with the Python tutorial.
t = 0;
for num = 1:3
    for vv = v
        gmsh.view.option.setNumber(vv, "TimeStep", t);
    end
    current_step = gmsh.view.option.getNumber(v(1), "TimeStep");
    max_step     = gmsh.view.option.getNumber(v(1), "NbTimeStep") - 1;
    if current_step < max_step
        t = t + 1;
    else
        t = 0;
    end

    gmsh.view.option.setNumber(v(1), "RaiseZ", ...
        gmsh.view.option.getNumber(v(1), "RaiseZ") + ...
        0.01 / gmsh.view.option.getNumber(v(1), "Max") * t);

    if num == 3
        gmsh.option.setNumber("General.GraphicsWidth", ...
            gmsh.option.getNumber("General.MenuWidth") + 640);
        gmsh.option.setNumber("General.GraphicsHeight", 480);
    end

    frames = 50;
    for num2 = 1:frames %#ok<NASGU>
        gmsh.option.setNumber("General.RotationX", ...
            gmsh.option.getNumber("General.RotationX") + 10);
        gmsh.option.setNumber("General.RotationY", ...
            gmsh.option.getNumber("General.RotationX") / 3);
        gmsh.option.setNumber("General.RotationZ", ...
            gmsh.option.getNumber("General.RotationZ") + 0.1);
        gmsh.graphics.draw();
    end
end

gmsh.finalize();
