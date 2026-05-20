function outDimTags = importShapes(fileName, highestDimOnly, format)
%IMPORTSHAPES  gmsh.model.occ.importShapes
%   Import BREP, STEP or IGES shapes from the file `fileName' in the OpenCASCADE
%   CAD representation. The imported entities are returned in `outDimTags', as a
%   vector of (dim, tag) pairs. If the optional argument `highestDimOnly' is
%   set, only import the highest dimensional entities in the file. The optional
%   argument `format' can be used to force the format of the file (currently
%   "brep", "step" or "iges").
%
%   Inputs:
%     fileName - string
%     highestDimOnly - logical scalar (default true)
%     format - string (default '')
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        fileName (1,:) char
        highestDimOnly (1,1) logical = true
        format (1,:) char = ''
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccImportShapes', fileName, highestDimOnly, format);
end
