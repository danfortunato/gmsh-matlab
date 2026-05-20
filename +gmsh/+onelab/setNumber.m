function setNumber(name, value)
%SETNUMBER  gmsh.onelab.setNumber
%   Set the value of the number parameter `name' in the ONELAB database. Create
%   the parameter if it does not exist; update the value if the parameter
%   exists.
%
%   Inputs:
%     name - string
%     value - vector of doubles

    arguments
        name (1,:) char
        value
    end

    gmsh.internal.api.call('gmshOnelabSetNumber', name, value);
end
