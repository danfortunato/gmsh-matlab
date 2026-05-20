function removePhysicalName(name)
%REMOVEPHYSICALNAME  gmsh.model.removePhysicalName
%   Remove the physical name `name' from the current model.
%
%   Inputs:
%     name - string

    arguments
        name (1,:) char
    end

    gmsh.internal.api.call('gmshModelRemovePhysicalName', name);
end
