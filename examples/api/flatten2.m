function flatten2(filename)
%FLATTEN2  Port of flatten2.py: zero all node z-coordinates via affineTransform.
%   Without an argument, prints a usage hint and returns.
    if nargin < 1
        fprintf('Usage: flatten2(''path/to/mesh.msh'')\n');
        return
    end
    gmsh.initialize();
    try
        gmsh.open(filename);
    catch
        gmsh.finalize();
        return
    end
    gmsh.model.mesh.affineTransform( ...
        [1, 0, 0, 0, ...
         0, 1, 0, 0, ...
         0, 0, 0, 0]);
    gmsh.finalize();
end
