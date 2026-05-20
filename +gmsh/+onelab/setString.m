function setString(name, value)
%SETSTRING  gmsh.onelab.setString
%   Set the value of the string parameter `name' in the ONELAB database. Create
%   the parameter if it does not exist; update the value if the parameter
%   exists.
%
%   Inputs:
%     name - string
%     value - cell of strings

    arguments
        name (1,:) char
        value
    end

    gmsh.internal.api.call('gmshOnelabSetString', name, value);
end
