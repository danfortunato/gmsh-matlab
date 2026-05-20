% Gmsh MATLAB extended tutorial 2 — Mesh import, discrete entities, terrain meshing.

gmsh.initialize();
gmsh.model.add("x2");

N = 100;
tag = @(i, j) (N + 1) * i + j + 1;

% Preallocate
nNodes = (N+1)*(N+1);
coords = zeros(1, 3*nNodes);
nodes  = zeros(1, nNodes);
tris   = [];
lin    = {[], [], [], []};
pnt    = [tag(0,0), tag(N,0), tag(N,N), tag(0,N)];

for i = 0:N
    for j = 0:N
        idx = (N+1)*i + j + 1;
        nodes(idx) = tag(i, j);
        coords(3*idx-2:3*idx) = [i/N, j/N, 0.05*sin(10*(i+j)/N)];
        if i > 0 && j > 0
            tris = [tris, tag(i-1, j-1), tag(i, j-1), tag(i-1, j), ...
                          tag(i, j-1),   tag(i, j),   tag(i-1, j)]; %#ok<AGROW>
        end
        if (i == 0 || i == N) && j > 0
            k = 4; if i == 0, k = 4; else, k = 2; end  % python uses idx 3 or 1; matlab is 1-based -> 4 or 2
            lin{k} = [lin{k}, tag(i, j-1), tag(i, j)];
        end
        if (j == 0 || j == N) && i > 0
            k = 1; if j == 0, k = 1; else, k = 3; end
            lin{k} = [lin{k}, tag(i-1, j), tag(i, j)];
        end
    end
end

for i = 1:4
    gmsh.model.addDiscreteEntity(0, i, []);
end
gmsh.model.setCoordinates(1, 0, 0, coords(3*tag(0,0)));
gmsh.model.setCoordinates(2, 1, 0, coords(3*tag(N,0)));
gmsh.model.setCoordinates(3, 1, 1, coords(3*tag(N,N)));
gmsh.model.setCoordinates(4, 0, 1, coords(3*tag(0,N)));

for i = 1:4
    if i < 4
        nxt = i + 1;
    else
        nxt = 1;
    end
    gmsh.model.addDiscreteEntity(1, i, [i, nxt]);
end

gmsh.model.addDiscreteEntity(2, 1, [1, 2, -3, -4]);

gmsh.model.mesh.addNodes(2, 1, nodes, coords, []);

for i = 1:4
    gmsh.model.mesh.addElementsByType(i, 15, [], [pnt(i)]);
    gmsh.model.mesh.addElementsByType(i, 1,  [], lin{i});
end
gmsh.model.mesh.addElementsByType(1, 2, [], tris);

gmsh.model.mesh.reclassifyNodes();
gmsh.model.mesh.createGeometry([]);

p1 = gmsh.model.geo.addPoint(0, 0, -0.5);
p2 = gmsh.model.geo.addPoint(1, 0, -0.5);
p3 = gmsh.model.geo.addPoint(1, 1, -0.5);
p4 = gmsh.model.geo.addPoint(0, 1, -0.5);
c1 = gmsh.model.geo.addLine(p1, p2);
c2 = gmsh.model.geo.addLine(p2, p3);
c3 = gmsh.model.geo.addLine(p3, p4);
c4 = gmsh.model.geo.addLine(p4, p1);
c10 = gmsh.model.geo.addLine(p1, 1);
c11 = gmsh.model.geo.addLine(p2, 2);
c12 = gmsh.model.geo.addLine(p3, 3);
c13 = gmsh.model.geo.addLine(p4, 4);
ll1 = gmsh.model.geo.addCurveLoop([c1, c2, c3, c4]);
s1  = gmsh.model.geo.addPlaneSurface([ll1]); %#ok<NASGU>
ll3 = gmsh.model.geo.addCurveLoop([c1, c11, -1, -c10]);
s3  = gmsh.model.geo.addPlaneSurface([ll3]); %#ok<NASGU>
ll4 = gmsh.model.geo.addCurveLoop([c2, c12, -2, -c11]);
s4  = gmsh.model.geo.addPlaneSurface([ll4]); %#ok<NASGU>
ll5 = gmsh.model.geo.addCurveLoop([c3, c13, 3, -c12]);
s5  = gmsh.model.geo.addPlaneSurface([ll5]); %#ok<NASGU>
ll6 = gmsh.model.geo.addCurveLoop([c4, c10, 4, -c13]);
s6  = gmsh.model.geo.addPlaneSurface([ll6]); %#ok<NASGU>
sl1 = gmsh.model.geo.addSurfaceLoop([s1, s3, s4, s5, s6, 1]);
v1  = gmsh.model.geo.addVolume([sl1]); %#ok<NASGU>
gmsh.model.geo.synchronize();

gmsh.option.setNumber('Mesh.MeshSizeMin', 0.05);
gmsh.option.setNumber('Mesh.MeshSizeMax', 0.05);

gmsh.model.mesh.generate(3);
gmsh.write('x2.msh');
gmsh.finalize();
