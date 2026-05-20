function run(name, command)
%RUN  gmsh.onelab.run
%   Run a ONELAB client. If `name' is provided, create a new ONELAB client with
%   name `name' and executes `command'. If not, try to run a client that might
%   be linked to the processed input files.
%
%   Inputs:
%     name - string (default '')
%     command - string (default '')

    arguments
        name (1,:) char = ''
        command (1,:) char = ''
    end

    gmsh.internal.api.call('gmshOnelabRun', name, command);
end
