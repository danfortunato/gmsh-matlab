function initialize(readConfigFiles, run)
%INITIALIZE  gmsh.initialize
%   Initialize the Gmsh API. This must be called before any call to the other
%   functions in the API. If `argc' and `argv' (or just `argv' in Python or
%   Julia) are provided, they will be handled in the same way as the command
%   line arguments in the Gmsh app. If `readConfigFiles' is set, read system
%   Gmsh configuration files (gmshrc and gmsh-options). If `run' is set, run in
%   the same way as the Gmsh app, either interactively or in batch mode
%   depending on the command line arguments. If `run' is not set, initializing
%   the API sets the options "General.AbortOnError" to 2 and "General.Terminal"
%   to 1.
%
%   Inputs:
%     readConfigFiles - logical scalar (default true)
%     run - logical scalar (default false)

    arguments
        readConfigFiles (1,1) logical = true
        run (1,1) logical = false
    end

    gmsh.internal.api.call('gmshInitialize', readConfigFiles, run);
end
