% Free-form deformation in cylindrical coordinates (contributed by Ekrem Ekici).

gmsh.initialize();
gmsh.option.setNumber("General.Terminal", 0);
gmsh.model.add("original_model");

R = 0.1;
L_total = 0.4;

gmsh.model.occ.addCylinder(0, 0, 0, 0, 0, L_total, R, 1);
gmsh.model.occ.synchronize();

lc = 0.1;
gmsh.option.setNumber("Mesh.MeshSizeMax", lc);
gmsh.option.setNumber("Mesh.SaveAll", 0);
gmsh.model.mesh.generate(3);

% Snapshot the mesh, keyed by entity.
ents = gmsh.model.getEntities();
nE = size(ents, 1);
snap = cell(1, nE);   % {bnd, {nt,nc,np}, {et,etgs,ent_}}
for k = 1:nE
    d = ents(k, 1); t = ents(k, 2);
    bnd_k = gmsh.model.getBoundary(ents(k, :));
    [nt, nc, np] = gmsh.model.mesh.getNodes(d, t);
    [et, etgs, ent_] = gmsh.model.mesh.getElements(d, t);
    snap{k} = {bnd_k, {nt, nc, np}, {et, etgs, ent_}};
end

gmsh.write("cylinder.msh");

% FFD control-point grid.
l = 2;  m = 4;  n = 5;
Pr   = zeros(l, m, n);
Pphi = zeros(l, m, n);
Pz   = zeros(l, m, n);

[~, coords, ~] = gmsh.model.mesh.getNodes(3, -1, true, true);
coords = double(coords);
xs = coords(1:3:end);
ys = coords(2:3:end);
zs = coords(3:3:end);
[rhos, phis, zetas] = cart2cyl(xs, ys, zs);

dr   = max(rhos)  - min(rhos);
dphi = 2*pi;
dz   = max(zetas) - min(zetas);

for i = 1:l
    for j = 1:m
        for k = 1:n
            Pr(i, j, k)   = min(rhos)  + dr   * (i - 1) / (l - 1);
            Pphi(i, j, k) = min(phis)  + dphi * (j - 1) / (m - 1);
            Pz(i, j, k)   = min(zetas) + dz   * (k - 1) / (n - 1);
        end
    end
end

P0 = [Pr(1, 1, 1), Pphi(1, 1, 1), Pz(1, 1, 1)];

% Move some control points.
for i = 1:m
    Pr(2, i, 3) = Pr(2, i, 3) + 0.02;
    Pr(2, i, 5) = Pr(2, i, 5) - 0.02;
    Pz(2, i, 1) = Pz(2, i, 1) + 0.05;
end

gmsh.model.add('deformed_model');

for k = 1:nE
    d = ents(k, 1); t = ents(k, 2);
    bnd  = snap{k}{1};
    old_coord = double(snap{k}{2}{2});
    Xdef = deform(old_coord, P0, dr, dphi, dz, Pr, Pphi, Pz, l, m, n);
    [Xc, Yc, Zc] = cyl2cart(Xdef(:, 1), Xdef(:, 2), Xdef(:, 3));
    new_coord = reshape([Xc, Yc, Zc].', 1, []);
    bnd_tags = bnd(:, 2).';
    gmsh.model.addDiscreteEntity(d, t, bnd_tags);
    gmsh.model.mesh.addNodes(d, t, snap{k}{2}{1}, new_coord);
    gmsh.model.mesh.addElements(d, t, snap{k}{3}{1}, snap{k}{3}{2}, snap{k}{3}{3});
end

gmsh.write("cylinder_deformed.msh");
gmsh.finalize();


function [rho, phi, zeta] = cart2cyl(x, y, z)
    rho  = sqrt(x.^2 + y.^2);
    phi  = atan2(y, x);
    zeta = z;
end

function [x, y, z] = cyl2cart(rho, phi, zeta)
    x = rho .* cos(phi);
    y = rho .* sin(phi);
    z = zeta;
end

function Xdef = deform(coords, P0, dr, dphi, dz, Pr, Pphi, Pz, l, m, n)
    xs = coords(1:3:end);
    ys = coords(2:3:end);
    zs = coords(3:3:end);
    [rhos, phis, zetas] = cart2cyl(xs, ys, zs);
    s = (rhos  - P0(1)) / dr;
    t = (phis  - P0(2)) / dphi;
    u = (zetas - P0(3)) / dz;
    N = numel(s);
    Xdef = zeros(N, 3);
    for i = 0:l-1
        for j = 0:m-1
            for k = 0:n-1
                w = nchoosek(l-1, i) .* (1 - s).^(l-1-i) .* s.^i ...
                 .* nchoosek(m-1, j) .* (1 - t).^(m-1-j) .* t.^j ...
                 .* nchoosek(n-1, k) .* (1 - u).^(n-1-k) .* u.^k;
                Xdef(:, 1) = Xdef(:, 1) + w(:) .* Pr(i+1,   j+1, k+1);
                Xdef(:, 2) = Xdef(:, 2) + w(:) .* Pphi(i+1, j+1, k+1);
                Xdef(:, 3) = Xdef(:, 3) + w(:) .* Pz(i+1,   j+1, k+1);
            end
        end
    end
end
