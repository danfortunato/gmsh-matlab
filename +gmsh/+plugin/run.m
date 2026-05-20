function ret = run(name)
%RUN  gmsh.plugin.run
%   Run the plugin `name'. Return the tag of the created view (if any). Plugins
%   available in the official Gmsh release are listed in the "Gmsh plugins"
%   chapter of the Gmsh reference manual
%   (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-plugins).
%
%   Inputs:
%     name - string
%
%   Outputs:
%     ret - integer scalar

    arguments
        name (1,:) char
    end

    ret = gmsh.internal.api.call('gmshPluginRun', name);
end
