function ex_open(filename)
%EX_OPEN  Port of open.py (renamed from open to avoid shadowing the
%   MATLAB built-in `open`). ex_open(FILENAME) opens FILENAME with gmsh,
%   meshes in 3D, and writes test.msh. Without an argument, prints a usage
%   hint and returns.
    if nargin < 1
        fprintf('Usage: ex_open(''path/to/file.geo'')\n');
        return
    end
    gmsh.initialize();
    try
        gmsh.open(filename);
    catch
        gmsh.finalize();
        return
    end
    gmsh.model.mesh.generate(3);
    gmsh.write("test.msh");
    gmsh.finalize();
end
