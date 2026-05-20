gmsh.initialize();
beg = gmsh.model.occ.addPoint(0, 0, 0);
endp = gmsh.model.occ.addPoint(1, 1, 0);
mid = gmsh.model.occ.addPoint(1, 0, 0);
% mid is center
gmsh.model.occ.addCircleArc(beg, mid, endp);
% arc goes through mid
gmsh.model.occ.addCircleArc(beg, mid, endp, -1, false);
gmsh.model.occ.synchronize();
gmsh.finalize();
