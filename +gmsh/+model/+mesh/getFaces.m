function [faceTags, faceOrientations] = getFaces(faceType, nodeTags)
%GETFACES  gmsh.model.mesh.getFaces
%   Get the global unique mesh face identifiers `faceTags' and orientations
%   `faceOrientations' for an input list of a multiple of three (if `faceType'
%   == 3) or four (if `faceType' == 4) node tags defining these faces,
%   concatenated in the vector `nodeTags'. Mesh faces are created e.g. by
%   `createFaces()', `getKeys()' or `addFaces()'.
%
%   Inputs:
%     faceType - integer scalar
%     nodeTags - vector of size_t
%
%   Outputs:
%     faceTags - row vector of uint64
%     faceOrientations - row vector of int32

    arguments
        faceType (1,1) {mustBeInteger}
        nodeTags
    end

    [faceTags, faceOrientations] = gmsh.internal.api.call('gmshModelMeshGetFaces', faceType, nodeTags);
end
