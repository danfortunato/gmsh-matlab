% ------------------------------------------------------------------------------
%
%  Gmsh MATLAB tutorial 9
%
%  Plugins
%
% ------------------------------------------------------------------------------

gmsh.initialize();

% Load a 3D scalar view from the gmsh tutorial assets.
here = fileparts(mfilename('fullpath'));
viewfile = fullfile(here, 'view3.pos');
gmsh.merge(viewfile);
v = gmsh.view.getTags();
if numel(v) ~= 1
    gmsh.logger.write("Wrong number of views!", "error");
    gmsh.finalize();
    return
end

% Configure and run the `Isosurface' plugin.
gmsh.plugin.setNumber("Isosurface", "Value", 0.67);
gmsh.plugin.setNumber("Isosurface", "View", 0);
v1 = gmsh.plugin.run("Isosurface");

% Configure and run the `CutPlane' plugin (A*x+B*y+C*z+D=0).
gmsh.plugin.setNumber("CutPlane", "A", 0);
gmsh.plugin.setNumber("CutPlane", "B", 0.2);
gmsh.plugin.setNumber("CutPlane", "C", 1);
gmsh.plugin.setNumber("CutPlane", "D", 0);
gmsh.plugin.setNumber("CutPlane", "View", 0);
v2 = gmsh.plugin.run("CutPlane");

% Add a title via the `Annotate' plugin.
gmsh.plugin.setString("Annotate", "Text", "A nice title");
gmsh.plugin.setNumber("Annotate", "X", 1e5);
gmsh.plugin.setNumber("Annotate", "Y", 50);
gmsh.plugin.setString("Annotate", "Font", "Times-BoldItalic");
gmsh.plugin.setNumber("Annotate", "FontSize", 28);
gmsh.plugin.setString("Annotate", "Align", "Center");
gmsh.plugin.setNumber("Annotate", "View", 0);
gmsh.plugin.run("Annotate");

gmsh.plugin.setString("Annotate", "Text", "(and a small subtitle)");
gmsh.plugin.setNumber("Annotate", "Y", 70);
gmsh.plugin.setString("Annotate", "Font", "Times-Roman");
gmsh.plugin.setNumber("Annotate", "FontSize", 12);
gmsh.plugin.run("Annotate");

% Tweak view options.
gmsh.view.option.setNumber(v(1), "Light", 1);
gmsh.view.option.setNumber(v(1), "IntervalsType", 1);
gmsh.view.option.setNumber(v(1), "NbIso", 6);
gmsh.view.option.setNumber(v(1), "SmoothNormals", 1);
gmsh.view.option.setNumber(v1, "IntervalsType", 2);
gmsh.view.option.setNumber(v2, "IntervalsType", 2);

gmsh.finalize();
