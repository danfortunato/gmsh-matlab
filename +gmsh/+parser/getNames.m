function names = getNames(search)
%GETNAMES  gmsh.parser.getNames
%   Get the names of the variables in the Gmsh parser matching the `search'
%   regular expression. If `search' is empty, return all the names.
%
%   Inputs:
%     search - string (default '')
%
%   Outputs:
%     names - cell of strings

    arguments
        search (1,:) char = ''
    end

    names = gmsh.internal.api.call('gmshParserGetNames', search);
end
