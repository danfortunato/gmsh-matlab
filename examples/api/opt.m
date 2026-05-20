function opt(filename)
%OPT  Port of opt.py: open a mesh and run mesh optimization on discrete volumes.
%   opt(FILENAME) opens FILENAME, runs gmsh.model.mesh.optimize('', true), and
%   writes opt.msh. Without an argument, prints a usage hint and returns.
    if nargin < 1
        fprintf('Usage: opt(''path/to/mesh.msh'')\n');
        return
    end
    gmsh.initialize();
    try
        gmsh.open(filename);
    catch
        gmsh.finalize();
        return
    end
    gmsh.model.mesh.optimize('', true);
    gmsh.write('opt.msh');
    gmsh.finalize();
end
