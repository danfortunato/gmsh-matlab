% When gmsh is compiled with OpenMP support the meshing pipeline is
% multi-threaded; the number of threads is governed by the General.NumThreads
% option. (multi_process.py uses Python's multiprocessing module to run
% independent gmsh instances and is not portable to MATLAB.)

gmsh.initialize();

for i = 0:4
    gmsh.model.occ.addRectangle(i, 0, 0, 1, 1);
end

gmsh.model.occ.synchronize();
gmsh.option.setNumber('Mesh.MeshSizeMax', 0.005);
gmsh.option.setNumber('General.NumThreads', 5);
gmsh.model.mesh.generate(2);
gmsh.finalize();
disp("All done");
