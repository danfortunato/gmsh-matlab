function setAttribute(name, values)
%SETATTRIBUTE  gmsh.model.setAttribute
%   Set the values of the attribute with name `name'.
%
%   Inputs:
%     name - string
%     values - cell of strings

    arguments
        name (1,:) char
        values
    end

    gmsh.internal.api.call('gmshModelSetAttribute', name, values);
end
