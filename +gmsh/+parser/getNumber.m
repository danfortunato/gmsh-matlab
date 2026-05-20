function value = getNumber(name)
%GETNUMBER  gmsh.parser.getNumber
%   Get the value of the number variable `name' from the Gmsh parser. Return an
%   empty vector if the variable does not exist.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     value - row vector of doubles

    arguments
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshParserGetNumber', name);
end
