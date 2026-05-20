gmsh.initialize();

here = fileparts(mfilename('fullpath'));
gmsh.merge(fullfile(here, 'step_boundary_colors.stp'));

ents = gmsh.model.getEntities();
for i = 1:size(ents, 1)
    dim = ents(i, 1);
    tag = ents(i, 2);
    [r, g, b, a] = gmsh.model.getColor(dim, tag);
    if r ~= 0 || g ~= 0 || b ~= 255 || a ~= 0
        fprintf('entity (%d, %d) color (%d, %d, %d, %d)\n', dim, tag, r, g, b, a);
    end
end

gmsh.finalize();
