function value = getString(name)
%GETSTRING  gmsh.parser.getString
%   Get the value of the string variable `name' from the Gmsh parser. Return an
%   empty vector if the variable does not exist.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     value - cell of strings

    arguments
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshParserGetString', name);
end
