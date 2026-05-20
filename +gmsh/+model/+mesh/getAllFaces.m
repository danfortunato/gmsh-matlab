function [faceTags, faceNodes] = getAllFaces(faceType)
%GETALLFACES  gmsh.model.mesh.getAllFaces
%   Get the global unique identifiers `faceTags' and the nodes `faceNodes' of
%   the faces of type `faceType' in the mesh. Mesh faces are created e.g. by
%   `createFaces()', `getKeys()' or addFaces().
%
%   Inputs:
%     faceType - integer scalar
%
%   Outputs:
%     faceTags - row vector of uint64
%     faceNodes - row vector of uint64

    arguments
        faceType (1,1) {mustBeInteger}
    end

    [faceTags, faceNodes] = gmsh.internal.api.call('gmshModelMeshGetAllFaces', faceType);
end
