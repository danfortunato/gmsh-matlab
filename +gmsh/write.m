function write(fileName)
%WRITE  gmsh.write
%   Write a file. The export format is determined by the file extension.
%
%   Inputs:
%     fileName - string

    arguments
        fileName (1,:) char
    end

    gmsh.internal.api.call('gmshWrite', fileName);
end
