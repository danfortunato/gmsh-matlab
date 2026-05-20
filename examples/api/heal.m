gmsh.initialize();

here = fileparts(mfilename('fullpath'));
gmsh.open(fullfile(here, 'as1-tu-203.stp'));

ent = gmsh.model.getEntities(); %#ok<NASGU>

gmsh.model.occ.healShapes();
gmsh.model.occ.synchronize();

gmsh.finalize();
