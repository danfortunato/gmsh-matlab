function removeEntityName(name)
%REMOVEENTITYNAME  gmsh.model.removeEntityName
%   Remove the entity name `name' from the current model.
%
%   Inputs:
%     name - string

    arguments
        name (1,:) char
    end

    gmsh.internal.api.call('gmshModelRemoveEntityName', name);
end
