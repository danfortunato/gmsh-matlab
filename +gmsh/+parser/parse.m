function parse(fileName)
%PARSE  gmsh.parser.parse
%   Parse the file `fileName' with the Gmsh parser.
%
%   Inputs:
%     fileName - string

    arguments
        fileName (1,:) char
    end

    gmsh.internal.api.call('gmshParserParse', fileName);
end
