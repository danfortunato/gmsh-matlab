function setString(name, option, value)
%SETSTRING  gmsh.plugin.setString
%   Set the string option `option' to the value `value' for plugin `name'.
%   Plugins available in the official Gmsh release are listed in the "Gmsh
%   plugins" chapter of the Gmsh reference manual
%   (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-plugins).
%
%   Inputs:
%     name - string
%     option - string
%     value - string

    arguments
        name (1,:) char
        option (1,:) char
        value (1,:) char
    end

    gmsh.internal.api.call('gmshPluginSetString', name, option, value);
end
