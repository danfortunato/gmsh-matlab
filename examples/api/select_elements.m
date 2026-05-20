gmsh.initialize();
gmsh.model.occ.addRectangle(0, 0, 0, 1, 1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.generate();

% Interactive element selection requires the FLTK GUI; nothing to do under
% headless / batch use.
gmsh.finalize();
return %#ok<UNRCH>

while true %#ok<UNRCH>
    gmsh.fltk.setStatusMessage("Select an element, or press 'q' to quit", true);
    [ret, ele] = gmsh.fltk.selectElements();
    if ret == 0, break, end
    disp(ele);
end

gmsh.finalize();
