function setFileName(fileName)
%SETFILENAME  gmsh.model.setFileName
%   Set the file name associated with the current model.
%
%   Inputs:
%     fileName - string

    arguments
        fileName (1,:) char
    end

    gmsh.internal.api.call('gmshModelSetFileName', fileName);
end
