function addFaces(faceType, faceTags, faceNodes)
%ADDFACES  gmsh.model.mesh.addFaces
%   Add mesh faces of type `faceType' defined by their global unique identifiers
%   `faceTags' and their nodes `faceNodes'.
%
%   Inputs:
%     faceType - integer scalar
%     faceTags - vector of size_t
%     faceNodes - vector of size_t

    arguments
        faceType (1,1) {mustBeInteger}
        faceTags
        faceNodes
    end

    gmsh.internal.api.call('gmshModelMeshAddFaces', faceType, faceTags, faceNodes);
end
