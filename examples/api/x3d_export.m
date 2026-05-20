function x3d_export(varargin)
%X3D_EXPORT  Port of x3d_export.py: write the STEP assembly as an X3D file.
%   x3d_export() runs with defaults equivalent to the Python script's argparse
%   defaults. Optional name-value pairs:
%       'surface_mode' (int, default 2)
%       'split'        (int, default 0)
%       'colorize'     (int, default 1)
    p = inputParser;
    addParameter(p, 'surface_mode', 2, @(x) isnumeric(x) && isscalar(x));
    addParameter(p, 'split',        0, @(x) isnumeric(x) && isscalar(x));
    addParameter(p, 'colorize',     1, @(x) isnumeric(x) && isscalar(x));
    parse(p, varargin{:});
    args = p.Results;

    gmsh.initialize();

    here = fileparts(mfilename('fullpath'));
    gmsh.open(fullfile(here, 'as1-tu-203.stp'));

    outdir = fullfile(pwd, 'x3d_output');
    if ~isfolder(outdir), mkdir(outdir); end

    gmsh.option.setNumber('Print.X3dSurfaces', args.surface_mode);
    gmsh.option.setNumber('Print.X3dVolumes',  args.split);
    gmsh.option.setNumber('Print.X3dColorize', args.colorize);

    gmsh.write(fullfile(outdir, 'out.x3d'));
    gmsh.clear();
    gmsh.finalize();
end
