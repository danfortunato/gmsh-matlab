function fileName = getFileName()
%GETFILENAME  gmsh.model.getFileName
%   Get the file name (if any) associated with the current model. A file name is
%   associated when a model is read from a file on disk.
%
%   Outputs:
%     fileName - string

    fileName = gmsh.internal.api.call('gmshModelGetFileName');
end
