function [tagMaster, typeKeys, typeKeysMaster, entityKeys, entityKeysMaster, coord, coordMaster] = getPeriodicKeys(elementType, functionSpaceType, tag, returnCoord)
%GETPERIODICKEYS  gmsh.model.mesh.getPeriodicKeys
%   Get the master entity `tagMaster' and the key pairs (`typeKeyMaster',
%   `entityKeyMaster') corresponding to the entity `tag' and the key pairs
%   (`typeKey', `entityKey') for the elements of type `elementType' and function
%   space type `functionSpaceType'. If `returnCoord' is set, the `coord' and
%   `coordMaster' vectors contain the x, y, z coordinates locating basis
%   functions for sorting purposes.
%
%   Inputs:
%     elementType - integer scalar
%     functionSpaceType - string
%     tag - integer scalar
%     returnCoord - logical scalar (default true)
%
%   Outputs:
%     tagMaster - integer scalar
%     typeKeys - row vector of int32
%     typeKeysMaster - row vector of int32
%     entityKeys - row vector of uint64
%     entityKeysMaster - row vector of uint64
%     coord - row vector of doubles
%     coordMaster - row vector of doubles

    arguments
        elementType (1,1) {mustBeInteger}
        functionSpaceType (1,:) char
        tag (1,1) {mustBeInteger}
        returnCoord (1,1) logical = true
    end

    [tagMaster, typeKeys, typeKeysMaster, entityKeys, entityKeysMaster, coord, coordMaster] = gmsh.internal.api.call('gmshModelMeshGetPeriodicKeys', elementType, functionSpaceType, tag, returnCoord);
end
