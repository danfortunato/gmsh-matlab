gmsh.initialize();
gmsh.model.add("NACA 0012 with a round tip");

incidence = -pi/18;
z = 0.63;
fact = 1; lc1 = 0.01 * fact; lc2 = 0.3 * fact;
gmsh.option.setNumber('Mesh.Algorithm3D', 10);
order2 = false;

naca = [0.9987518, 0.0014399, 0.9976658, 0.0015870, 0.9947532, 0.0019938, ...
        0.9906850, 0.0025595, 0.9854709, 0.0032804, 0.9791229, 0.0041519, ...
        0.9716559, 0.0051685, 0.9630873, 0.0063238, 0.9534372, 0.0076108, ...
        0.9427280, 0.0090217, 0.9309849, 0.0105485, 0.9182351, 0.0121823, ...
        0.9045085, 0.0139143, 0.8898372, 0.0157351, 0.8742554, 0.0176353, ...
        0.8577995, 0.0196051, 0.8405079, 0.0216347, 0.8224211, 0.0237142, ...
        0.8035813, 0.0258337, 0.7840324, 0.0279828, 0.7638202, 0.0301515, ...
        0.7429917, 0.0323294, 0.7215958, 0.0345058, 0.6996823, 0.0366700, ...
        0.6773025, 0.0388109, 0.6545085, 0.0409174, 0.6313537, 0.0429778, ...
        0.6078921, 0.0449802, 0.5841786, 0.0469124, 0.5602683, 0.0487619, ...
        0.5362174, 0.0505161, 0.5120819, 0.0521620, 0.4879181, 0.0536866, ...
        0.4637826, 0.0550769, 0.4397317, 0.0563200, 0.4158215, 0.0574033, ...
        0.3921079, 0.0583145, 0.3686463, 0.0590419, 0.3454915, 0.0595747, ...
        0.3226976, 0.0599028, 0.3003177, 0.0600172, 0.2784042, 0.0599102, ...
        0.2570083, 0.0595755, 0.2361799, 0.0590081, 0.2159676, 0.0582048, ...
        0.1964187, 0.0571640, 0.1775789, 0.0558856, 0.1594921, 0.0543715, ...
        0.1422005, 0.0526251, 0.1257446, 0.0506513, 0.1101628, 0.0484567, ...
        0.0954915, 0.0460489, 0.0817649, 0.0434371, 0.0690152, 0.0406310, ...
        0.0572720, 0.0376414, 0.0465628, 0.0344792, 0.0369127, 0.0311559, ...
        0.0283441, 0.0276827, 0.0208771, 0.0240706, 0.0145291, 0.0203300, ...
        0.0093149, 0.0164706, 0.0052468, 0.0125011, 0.0023342, 0.0084289, ...
        0.0005839, 0.0042603, 0.0000000, 0.0000000];

l = numel(naca);
pts = [];
for i = 0:l/2 - 1
    pts(end+1) = gmsh.model.occ.addPoint(naca(2*i+1), naca(2*i+2), 0); %#ok<AGROW>
end
for i = l/2 - 2:-1:0
    pts(end+1) = gmsh.model.occ.addPoint(naca(2*i+1), -naca(2*i+2), 0); %#ok<AGROW>
end
pts = fliplr(pts);
spl = gmsh.model.occ.addSpline(pts);

% Trailing edge circle.
c = gmsh.model.occ.addPoint(0.9985510, 0, 0);
cir = gmsh.model.occ.addCircleArc(pts(end), c, pts(1));

% Extrude the profile along z.
gmsh.model.occ.extrude([1, spl; 1, cir], 0, 0, z);

% Cut for the rounded wing tip.
[~, ~, ~, xmax, ~, ~] = gmsh.model.occ.getBoundingBox(1, cir);
p1 = gmsh.model.occ.addPoint(0, 0, 0);
p2 = gmsh.model.occ.addPoint(0, 0, z);
c1 = gmsh.model.occ.addLine(p1, p2);
p3 = gmsh.model.occ.addPoint(xmax, 0, 0);
p4 = gmsh.model.occ.addPoint(xmax, 0, z);
c2 = gmsh.model.occ.addLine(p3, p4);
gmsh.model.occ.fragment([1, c1; 1, c2], gmsh.model.occ.getEntities(2));

eps = 1e-6;
gmsh.option.setNumber('Geometry.OCCBoundsUseStl', 1);
gmsh.model.occ.synchronize();
tc = gmsh.model.getEntitiesInBoundingBox(-eps, -eps, z - eps, ...
    xmax + eps, 1, z + eps, 1);

% Rounded wing tip via revolution.
rev = gmsh.model.occ.revolve(tc, 0, 0, z, 1, 0, 0, pi/2);
gmsh.model.occ.revolve(rev(1:4:end, :), 0, 0, z, 1, 0, 0, pi/2);

gmsh.model.occ.fragment(gmsh.model.occ.getEntities(2), zeros(0, 2));
gmsh.model.occ.mesh.setSize(gmsh.model.occ.getEntities(0), lc1);

gmsh.model.occ.rotate(gmsh.model.occ.getEntities(2), 0.25, 0, 0, 0, 0, 1, incidence);
gmsh.model.occ.synchronize();

% Boundary layer extrusion.
N = 10; r = 2;
d = 1.7e-5;
for i = 1:N-1
    d(end+1) = d(end) + d(1) * r^i; %#ok<AGROW>
end
extbl = gmsh.model.geo.extrudeBoundaryLayer( ...
    gmsh.model.getEntities(2), ones(1, N), d, true);

% Top surfaces of the boundary layer.
top = zeros(0, 2);
for i = 2:size(extbl, 1)
    if extbl(i, 1) == 3
        top(end+1, :) = extbl(i - 1, :); %#ok<AGROW>
    end
end

gmsh.model.geo.synchronize();
bnd = gmsh.model.getBoundary(top);
cl2 = gmsh.model.geo.addCurveLoop(bnd(:, 2).');
p1 = gmsh.model.geo.addPoint(-1, -1, 0, lc2);
p2 = gmsh.model.geo.addPoint( 2, -1, 0, lc2);
p3 = gmsh.model.geo.addPoint( 2,  1, 0, lc2);
p4 = gmsh.model.geo.addPoint(-1,  1, 0, lc2);
l1 = gmsh.model.geo.addLine(p1, p2);
l2 = gmsh.model.geo.addLine(p2, p3);
l3 = gmsh.model.geo.addLine(p3, p4);
l4 = gmsh.model.geo.addLine(p4, p1);
cl3 = gmsh.model.geo.addCurveLoop([l1, l2, l3, l4]);
s2 = gmsh.model.geo.addPlaneSurface([cl3, cl2]);

p11 = gmsh.model.geo.addPoint(-1, -1, 2*z, lc2);
p12 = gmsh.model.geo.addPoint( 2, -1, 2*z, lc2);
p13 = gmsh.model.geo.addPoint( 2,  1, 2*z, lc2);
p14 = gmsh.model.geo.addPoint(-1,  1, 2*z, lc2);
l11 = gmsh.model.geo.addLine(p11, p12);
l12 = gmsh.model.geo.addLine(p12, p13);
l13 = gmsh.model.geo.addLine(p13, p14);
l14 = gmsh.model.geo.addLine(p14, p11);
l_1_11 = gmsh.model.geo.addLine(p1, p11);
l_2_12 = gmsh.model.geo.addLine(p2, p12);
l_3_13 = gmsh.model.geo.addLine(p3, p13);
l_4_14 = gmsh.model.geo.addLine(p4, p14);
cl3 = gmsh.model.geo.addCurveLoop([l11, l12, l13, l14]);
s3  = gmsh.model.geo.addPlaneSurface([cl3]);
cl4 = gmsh.model.geo.addCurveLoop([l1, l_2_12, -l11, -l_1_11]);
s4  = gmsh.model.geo.addPlaneSurface([cl4]);
cl5 = gmsh.model.geo.addCurveLoop([l2, l_3_13, -l12, -l_2_12]);
s5  = gmsh.model.geo.addPlaneSurface([cl5]);
cl6 = gmsh.model.geo.addCurveLoop([l3, l_4_14, -l13, -l_3_13]);
s6  = gmsh.model.geo.addPlaneSurface([cl6]);
cl7 = gmsh.model.geo.addCurveLoop([l4, l_1_11, -l14, -l_4_14]);
s7  = gmsh.model.geo.addPlaneSurface([cl7]);

b = [top(:, 2).', s2, s3, s4, s5, s6, s7];
sl = gmsh.model.geo.addSurfaceLoop(b);
gmsh.model.geo.addVolume([sl]);
gmsh.model.geo.synchronize();

gmsh.model.mesh.generate(3);

if order2
    gmsh.model.mesh.setOrder(2);
    gmsh.model.mesh.optimize('HighOrderFastCurving');
    gmsh.model.mesh.optimize('HighOrder');
end

gmsh.write('naca_boundary_layer_3d.msh');
gmsh.finalize();
