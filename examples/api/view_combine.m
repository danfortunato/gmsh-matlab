gmsh.initialize();

tri1 = [0., 1., 1., 0., 0., 1., 0., 0., 0.];
tri2 = [0., 1., 0., 0., 1., 1., 0., 0., 0.];

for step = 0:9
    tri1 = [tri1, 10., 10., 12. + step]; %#ok<AGROW>
    tri2 = [tri2, 10., 12. + step, 13. + step]; %#ok<AGROW>
end

t  = gmsh.view.add("some data");
gmsh.view.addListData(t, "ST", 1, tri1);

t2 = gmsh.view.add("some other data");
gmsh.view.addListData(t2, "ST", 1, tri2);

gmsh.view.combine("elements", "all", false);

gmsh.view.addAlias(t);
gmsh.finalize();
