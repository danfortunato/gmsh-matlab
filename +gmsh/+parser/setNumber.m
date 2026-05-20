function setNumber(name, value)
%SETNUMBER  gmsh.parser.setNumber
%   Set the value of the number variable `name' in the Gmsh parser. Create the
%   variable if it does not exist; update the value if the variable exists.
%
%   Inputs:
%     name - string
%     value - vector of doubles

    arguments
        name (1,:) char
        value
    end

    gmsh.internal.api.call('gmshParserSetNumber', name, value);
end
