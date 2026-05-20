function clear(name)
%CLEAR  gmsh.parser.clear
%   Clear all the Gmsh parser variables, or remove a single variable if `name'
%   is given.
%
%   Inputs:
%     name - string (default '')

    arguments
        name (1,:) char = ''
    end

    gmsh.internal.api.call('gmshParserClear', name);
end
