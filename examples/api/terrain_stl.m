gmsh.initialize();

here = fileparts(mfilename('fullpath'));
gmsh.merge(fullfile(here, 'terrain_stl_data.stl'));

% Classify surface mesh by angle + force curve splits on sharp corners.
gmsh.model.mesh.classifySurfaces(pi, true, true, pi/3);

gmsh.model.mesh.createGeometry();

s = gmsh.model.getEntities(2);
c = gmsh.model.getBoundary(s);

if size(c, 1) ~= 4
    gmsh.logger.write('Should have 4 boundary curves!', 'error');
end

z = -1000;

p = zeros(1, 4);
xyz = zeros(1, 0);
for k = 1:size(c, 1)
    pt = gmsh.model.getBoundary(c(k, :), false);
    p(k) = pt(1, 2);
    xyz = [xyz, gmsh.model.getValue(0, pt(1, 2), [])]; %#ok<AGROW>
end

p1 = gmsh.model.geo.addPoint(xyz(1),  xyz(2),  z);
p2 = gmsh.model.geo.addPoint(xyz(4),  xyz(5),  z);
p3 = gmsh.model.geo.addPoint(xyz(7),  xyz(8),  z);
p4 = gmsh.model.geo.addPoint(xyz(10), xyz(11), z);

c1 = gmsh.model.geo.addLine(p1, p2);
c2 = gmsh.model.geo.addLine(p2, p3);
c3 = gmsh.model.geo.addLine(p3, p4);
c4 = gmsh.model.geo.addLine(p4, p1);

c10 = gmsh.model.geo.addLine(p1, p(1));
c11 = gmsh.model.geo.addLine(p2, p(2));
c12 = gmsh.model.geo.addLine(p3, p(3));
c13 = gmsh.model.geo.addLine(p4, p(4));

ll1 = gmsh.model.geo.addCurveLoop([c1, c2, c3, c4]);
s1  = gmsh.model.geo.addPlaneSurface([ll1]);

ll3 = gmsh.model.geo.addCurveLoop([c1, c11, -c(1, 2), -c10]);
s3  = gmsh.model.geo.addPlaneSurface([ll3]);
ll4 = gmsh.model.geo.addCurveLoop([c2, c12, -c(2, 2), -c11]);
s4  = gmsh.model.geo.addPlaneSurface([ll4]);
ll5 = gmsh.model.geo.addCurveLoop([c3, c13, -c(3, 2), -c12]);
s5  = gmsh.model.geo.addPlaneSurface([ll5]);
ll6 = gmsh.model.geo.addCurveLoop([c4, c10, -c(4, 2), -c13]);
s6  = gmsh.model.geo.addPlaneSurface([ll6]);
sl1 = gmsh.model.geo.addSurfaceLoop([s1, s3, s4, s5, s6, s(1, 2)]);
v1  = gmsh.model.geo.addVolume([sl1]); %#ok<NASGU>

gmsh.model.geo.synchronize();

transfinite = false;
if transfinite
    NN = 30;
    curves = gmsh.model.getEntities(1);
    for k = 1:size(curves, 1)
        gmsh.model.mesh.setTransfiniteCurve(curves(k, 2), NN);
    end
    surfs = gmsh.model.getEntities(2);
    for k = 1:size(surfs, 1)
        gmsh.model.mesh.setTransfiniteSurface(surfs(k, 2));
        gmsh.model.mesh.setRecombine(surfs(k, 1), surfs(k, 2));
        gmsh.model.mesh.setSmoothing(surfs(k, 1), surfs(k, 2), 100);
    end
    gmsh.model.mesh.setTransfiniteVolume(v1);
else
    gmsh.option.setNumber('Mesh.MeshSizeMin', 100);
    gmsh.option.setNumber('Mesh.MeshSizeMax', 100);
end

gmsh.finalize();
