function removeAttribute(name)
%REMOVEATTRIBUTE  gmsh.model.removeAttribute
%   Remove the attribute with name `name'.
%
%   Inputs:
%     name - string

    arguments
        name (1,:) char
    end

    gmsh.internal.api.call('gmshModelRemoveAttribute', name);
end
