function values = getAttribute(name)
%GETATTRIBUTE  gmsh.model.getAttribute
%   Get the values of the attribute with name `name'.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     values - cell of strings

    arguments
        name (1,:) char
    end

    values = gmsh.internal.api.call('gmshModelGetAttribute', name);
end
