function setString(name, value)
%SETSTRING  gmsh.parser.setString
%   Set the value of the string variable `name' in the Gmsh parser. Create the
%   variable if it does not exist; update the value if the variable exists.
%
%   Inputs:
%     name - string
%     value - cell of strings

    arguments
        name (1,:) char
        value
    end

    gmsh.internal.api.call('gmshParserSetString', name, value);
end
