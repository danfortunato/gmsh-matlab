gmsh.initialize();

gmsh.model.add("terrain");

% N x N data points simulating a terrain surface.
N = 100;
coords = [];
nodes  = [];
tris   = [];
lin    = {[], [], [], []};

tag = @(i, j) (N + 1) * i + j + 1;
for i = 0:N
    for j = 0:N
        nodes(end+1) = tag(i, j); %#ok<AGROW>
        coords = [coords, i/N, j/N, 0.05*sin(10*(i+j)/N)]; %#ok<AGROW>
        if i > 0 && j > 0
            tris = [tris, tag(i-1, j-1), tag(i, j-1), tag(i-1, j)]; %#ok<AGROW>
            tris = [tris, tag(i, j-1), tag(i, j), tag(i-1, j)]; %#ok<AGROW>
        end
        if (i == 0 || i == N) && j > 0
            ix = 4; if i == 0, ix = 4; else, ix = 2; end
            lin{ix} = [lin{ix}, tag(i, j-1), tag(i, j)];
        end
        if (j == 0 || j == N) && i > 0
            ix = 1; if j == 0, ix = 1; else, ix = 3; end
            lin{ix} = [lin{ix}, tag(i-1, j), tag(i, j)];
        end
    end
end
pnt = [tag(0, 0), tag(N, 0), tag(N, N), tag(0, N)];

gmsh.model.geo.addPoint(0, 0, coords(3*tag(0, 0)), 1);
gmsh.model.geo.addPoint(1, 0, coords(3*tag(N, 0)), 2);
gmsh.model.geo.addPoint(1, 1, coords(3*tag(N, N)), 3);
gmsh.model.geo.addPoint(0, 1, coords(3*tag(0, N)), 4);
gmsh.model.geo.synchronize();

for i = 0:3
    next = mod(i, 4) + 2;
    if i == 3, next = 1; end
    gmsh.model.addDiscreteEntity(1, i + 1, [i + 1, next]);
end

gmsh.model.addDiscreteEntity(2, 1, [1, 2, -3, -4]);

gmsh.model.mesh.addNodes(2, 1, nodes, coords);

for i = 1:4
    gmsh.model.mesh.addElementsByType(i, 15, [], pnt(i));
    gmsh.model.mesh.addElementsByType(i, 1,  [], lin{i});
end
gmsh.model.mesh.addElementsByType(1, 2, [], tris);

gmsh.model.mesh.reclassifyNodes();
gmsh.model.mesh.createGeometry();

% Build a fully bounded volume above + below the terrain.
p1 = gmsh.model.geo.addPoint(0, 0, -0.5);
p2 = gmsh.model.geo.addPoint(1, 0, -0.5);
p3 = gmsh.model.geo.addPoint(1, 1, -0.5);
p4 = gmsh.model.geo.addPoint(0, 1, -0.5);
p5 = gmsh.model.geo.addPoint(0, 0,  0.5);
p6 = gmsh.model.geo.addPoint(1, 0,  0.5);
p7 = gmsh.model.geo.addPoint(1, 1,  0.5);
p8 = gmsh.model.geo.addPoint(0, 1,  0.5);

c1 = gmsh.model.geo.addLine(p1, p2);
c2 = gmsh.model.geo.addLine(p2, p3);
c3 = gmsh.model.geo.addLine(p3, p4);
c4 = gmsh.model.geo.addLine(p4, p1);

c5 = gmsh.model.geo.addLine(p5, p6);
c6 = gmsh.model.geo.addLine(p6, p7);
c7 = gmsh.model.geo.addLine(p7, p8);
c8 = gmsh.model.geo.addLine(p8, p5);

c10 = gmsh.model.geo.addLine(p1, 1);
c11 = gmsh.model.geo.addLine(p2, 2);
c12 = gmsh.model.geo.addLine(p3, 3);
c13 = gmsh.model.geo.addLine(p4, 4);

c14 = gmsh.model.geo.addLine(1, p5);
c15 = gmsh.model.geo.addLine(2, p6);
c16 = gmsh.model.geo.addLine(3, p7);
c17 = gmsh.model.geo.addLine(4, p8);

ll1 = gmsh.model.geo.addCurveLoop([c1, c2, c3, c4]);
s1  = gmsh.model.geo.addPlaneSurface([ll1]);
ll2 = gmsh.model.geo.addCurveLoop([c5, c6, c7, c8]);
s2  = gmsh.model.geo.addPlaneSurface([ll2]);

ll3 = gmsh.model.geo.addCurveLoop([c1, c11, -1, -c10]);
s3  = gmsh.model.geo.addPlaneSurface([ll3]);
ll4 = gmsh.model.geo.addCurveLoop([c2, c12, -2, -c11]);
s4  = gmsh.model.geo.addPlaneSurface([ll4]);
ll5 = gmsh.model.geo.addCurveLoop([c3, c13,  3, -c12]);
s5  = gmsh.model.geo.addPlaneSurface([ll5]);
ll6 = gmsh.model.geo.addCurveLoop([c4, c10,  4, -c13]);
s6  = gmsh.model.geo.addPlaneSurface([ll6]);
sl1 = gmsh.model.geo.addSurfaceLoop([s1, s3, s4, s5, s6, 1]);
v1  = gmsh.model.geo.addVolume([sl1]); %#ok<NASGU>

ll7  = gmsh.model.geo.addCurveLoop([c5, -c15, -1, c14]);
s7   = gmsh.model.geo.addPlaneSurface([ll7]);
ll8  = gmsh.model.geo.addCurveLoop([c6, -c16, -2, c15]);
s8   = gmsh.model.geo.addPlaneSurface([ll8]);
ll9  = gmsh.model.geo.addCurveLoop([c7, -c17,  3, c16]);
s9   = gmsh.model.geo.addPlaneSurface([ll9]);
ll10 = gmsh.model.geo.addCurveLoop([c8, -c14,  4, c17]);
s10  = gmsh.model.geo.addPlaneSurface([ll10]);
sl2  = gmsh.model.geo.addSurfaceLoop([s2, s7, s8, s9, s10, 1]);
v2   = gmsh.model.geo.addVolume([sl2]); %#ok<NASGU>

gmsh.model.geo.synchronize();

gmsh.option.setNumber('Mesh.MeshSizeMin', 0.05);
gmsh.option.setNumber('Mesh.MeshSizeMax', 0.05);

gmsh.finalize();
