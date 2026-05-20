gmsh.initialize();
gmsh.model.occ.addSphere(0, 0, 0, 1, 10);
gmsh.model.occ.addBox(0.5, 0, 0, 1.3, 2, 4, 11);
gmsh.model.occ.fragment([3, 10], [3, 11]);
gmsh.model.occ.synchronize();

dim = 2;
tag = 6;
N = 20;

bnd = gmsh.model.getBoundary([dim, tag], false);
for k = 1:size(bnd, 1)
    c = bnd(k, :);
    fprintf('curve (%d, %d)\n', c(1), c(2));
    [bmin, bmax] = gmsh.model.getParametrizationBounds(c(1), abs(c(2)));
    t = bmin(1) + (0:N-1) * (bmax(1) - bmin(1)) / N;
    uv  = gmsh.model.reparametrizeOnSurface(1, abs(c(2)), t, tag);
    xyz = gmsh.model.getValue(dim, tag, uv);
    for i = 1:3:numel(xyz)
        p = gmsh.model.addDiscreteEntity(0);
        gmsh.model.setCoordinates(p, xyz(i), xyz(i+1), xyz(i+2));
    end
end

gmsh.finalize();
