function merge(fileName)
%MERGE  gmsh.merge
%   Merge a file. Equivalent to the `File->Merge' menu in the Gmsh app. Handling
%   of the file depends on its extension and/or its contents. Merging a file
%   with model data will add the data to the current model.
%
%   Inputs:
%     fileName - string

    arguments
        fileName (1,:) char
    end

    gmsh.internal.api.call('gmshMerge', fileName);
end
