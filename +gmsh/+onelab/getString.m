function value = getString(name)
%GETSTRING  gmsh.onelab.getString
%   Get the value of the string parameter `name' from the ONELAB database.
%   Return an empty vector if the parameter does not exist.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     value - cell of strings

    arguments
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshOnelabGetString', name);
end
