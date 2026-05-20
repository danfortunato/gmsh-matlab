function infoKeys = getKeysInformation(typeKeys, entityKeys, elementType, functionSpaceType)
%GETKEYSINFORMATION  gmsh.model.mesh.getKeysInformation
%   Get information about the pair of `keys'. `infoKeys' returns information
%   about the functions associated with the pairs (`typeKeys', `entityKey').
%   `infoKeys[0].first' describes the type of function (0 for  vertex function,
%   1 for edge function, 2 for face function and 3 for bubble function).
%   `infoKeys[0].second' gives the order of the function associated with the
%   key. Warning: this is an experimental feature and will probably change in a
%   future release.
%
%   Inputs:
%     typeKeys - vector of integers
%     entityKeys - vector of size_t
%     elementType - integer scalar
%     functionSpaceType - string
%
%   Outputs:
%     infoKeys - Nx2 matrix of (dim,tag) pairs

    arguments
        typeKeys
        entityKeys
        elementType (1,1) {mustBeInteger}
        functionSpaceType (1,:) char
    end

    infoKeys = gmsh.internal.api.call('gmshModelMeshGetKeysInformation', typeKeys, entityKeys, elementType, functionSpaceType);
end
