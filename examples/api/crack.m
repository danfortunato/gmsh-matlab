gmsh.initialize();

gmsh.model.add("square with cracks");

surf1 = 1;
gmsh.model.occ.addRectangle(0, 0, 0, 1, 1, surf1);

pt1   = gmsh.model.occ.addPoint(0.2, 0.2, 0);
pt2   = gmsh.model.occ.addPoint(0.4, 0.4, 0);
line1 = gmsh.model.occ.addLine(pt1, pt2);
pt3   = gmsh.model.occ.addPoint(0.4, 0.4, 0);
pt4   = gmsh.model.occ.addPoint(0.4, 0.9, 0);
line2 = gmsh.model.occ.addLine(pt3, pt4);

[~, m] = gmsh.model.occ.fragment([2, surf1], [1, line1; 1, line2]);
gmsh.model.occ.synchronize();

% m{1} -> children of surf1; m{2..} -> children of each input line.
new_surf  = m{1}(1, 2);
new_lines = [];
for k = 2:numel(m)
    new_lines = [new_lines, m{k}(:, 2).']; %#ok<AGROW>
end

gmsh.model.addPhysicalGroup(2, [new_surf], 100);
gmsh.model.addPhysicalGroup(1, new_lines,  101);

gmsh.model.mesh.generate(2);

gmsh.plugin.setNumber("Crack", "Dimension", 1);
gmsh.plugin.setNumber("Crack", "PhysicalGroup", 101);
gmsh.plugin.setNumber("Crack", "DebugView", 1);
gmsh.plugin.run("Crack");

gmsh.option.setNumber("Mesh.SaveAll", 1);
gmsh.write("crack.msh");

gmsh.finalize();
