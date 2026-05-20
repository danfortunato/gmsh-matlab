function value = getNumber(name)
%GETNUMBER  gmsh.onelab.getNumber
%   Get the value of the number parameter `name' from the ONELAB database.
%   Return an empty vector if the parameter does not exist.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     value - row vector of doubles

    arguments
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshOnelabGetNumber', name);
end
