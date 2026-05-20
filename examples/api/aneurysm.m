gmsh.initialize();

here = fileparts(mfilename('fullpath'));
gmsh.merge(fullfile(here, 'aneurysm_data.stl'));
gmsh.model.mesh.classifySurfaces(pi, true, true);
gmsh.model.mesh.createGeometry();

extrude = true;

if extrude
    gmsh.option.setNumber('Geometry.ExtrudeReturnLateralEntities', 0);

    e1 = gmsh.model.geo.extrudeBoundaryLayer( ...
        gmsh.model.getEntities(2), [4], [0.5], true);

    e2 = gmsh.model.geo.extrudeBoundaryLayer( ...
        gmsh.model.getEntities(2), [4], [-0.5], true, true);

    top_mask = e2(:, 1) == 2;
    top_ent  = e2(top_mask, :);
    top_surf = top_ent(:, 2).';

    gmsh.model.geo.synchronize();
    bnd_ent  = gmsh.model.getBoundary(top_ent);
    bnd_curv = bnd_ent(:, 2).';

    loops = gmsh.model.geo.addCurveLoops(bnd_curv);
    bnd_surf = zeros(1, 0);
    for l = loops
        bnd_surf(end+1) = gmsh.model.geo.addPlaneSurface([l]); %#ok<AGROW>
    end

    vf = gmsh.model.geo.addVolume( ...
        [gmsh.model.geo.addSurfaceLoop([top_surf, bnd_surf])]);
    gmsh.model.geo.synchronize();

    solid_mask = e1(:, 1) == 3;
    fluid_bl_mask = e2(:, 1) == 3;
    gmsh.model.addPhysicalGroup(3, e1(solid_mask, 2).',    -1, "solid");
    gmsh.model.addPhysicalGroup(3, e2(fluid_bl_mask, 2).', -1, "fluid bl");
    gmsh.model.addPhysicalGroup(3, [vf], -1, "fluid");
end

gmsh.option.setNumber('Mesh.Algorithm', 1);
gmsh.option.setNumber('Mesh.MeshSizeFactor', 0.1);

gmsh.finalize();
