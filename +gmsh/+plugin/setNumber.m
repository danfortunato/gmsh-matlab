function setNumber(name, option, value)
%SETNUMBER  gmsh.plugin.setNumber
%   Set the numerical option `option' to the value `value' for plugin `name'.
%   Plugins available in the official Gmsh release are listed in the "Gmsh
%   plugins" chapter of the Gmsh reference manual
%   (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-plugins).
%
%   Inputs:
%     name - string
%     option - string
%     value - double scalar

    arguments
        name (1,:) char
        option (1,:) char
        value (1,1) double
    end

    gmsh.internal.api.call('gmshPluginSetNumber', name, option, value);
end
