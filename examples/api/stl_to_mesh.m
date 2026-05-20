gmsh.initialize();

% Load step file.
here = fileparts(mfilename('fullpath'));
gmsh.open(fullfile(here, 'as1-tu-203.stp'));

gmsh.model.occ.removeAllDuplicates();
gmsh.model.occ.synchronize();

% STL generation options.
gmsh.option.setNumber('Mesh.StlLinearDeflection', 1);
gmsh.option.setNumber('Mesh.StlLinearDeflectionRelative', 0);
gmsh.option.setNumber('Mesh.StlAngularDeflection', 0.5);

% Import the model STL as a mesh.
gmsh.model.mesh.importStl();
gmsh.model.mesh.removeDuplicateNodes();

% Create quads.
gmsh.option.setNumber('Mesh.RecombinationAlgorithm', 0);
gmsh.option.setNumber('Mesh.RecombineOptimizeTopology', 0);
gmsh.option.setNumber('Mesh.RecombineNodeRepositioning', 0);
gmsh.option.setNumber('Mesh.RecombineMinimumQuality', 1e-3);
gmsh.model.mesh.recombine();

gmsh.finalize();
