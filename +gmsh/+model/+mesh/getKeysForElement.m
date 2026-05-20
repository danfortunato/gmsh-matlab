function [typeKeys, entityKeys, coord] = getKeysForElement(elementTag, functionSpaceType, returnCoord)
%GETKEYSFORELEMENT  gmsh.model.mesh.getKeysForElement
%   Get the pair of keys for a single element `elementTag'.
%
%   Inputs:
%     elementTag - size_t scalar
%     functionSpaceType - string
%     returnCoord - logical scalar (default true)
%
%   Outputs:
%     typeKeys - row vector of int32
%     entityKeys - row vector of uint64
%     coord - row vector of doubles

    arguments
        elementTag (1,1) {mustBeInteger, mustBeNonnegative}
        functionSpaceType (1,:) char
        returnCoord (1,1) logical = true
    end

    [typeKeys, entityKeys, coord] = gmsh.internal.api.call('gmshModelMeshGetKeysForElement', elementTag, functionSpaceType, returnCoord);
end
