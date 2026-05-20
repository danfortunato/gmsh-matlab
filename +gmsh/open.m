function open(fileName)
%OPEN  gmsh.open
%   Open a file. Equivalent to the `File->Open' menu in the Gmsh app. Handling
%   of the file depends on its extension and/or its contents: opening a file
%   with model data will create a new model.
%
%   Inputs:
%     fileName - string

    arguments
        fileName (1,:) char
    end

    gmsh.internal.api.call('gmshOpen', fileName);
end
