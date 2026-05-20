function [typeKeys, entityKeys, coord] = getKeys(elementType, functionSpaceType, tag, returnCoord)
%GETKEYS  gmsh.model.mesh.getKeys
%   Generate the pair of keys for the elements of type `elementType' in the
%   entity of tag `tag', for the `functionSpaceType' function space. Each pair
%   (`typeKey', `entityKey') uniquely identifies a basis function in the
%   function space. If `returnCoord' is set, the `coord' vector contains the x,
%   y, z coordinates locating basis functions for sorting purposes. Warning:
%   this is an experimental feature and will probably change in a future
%   release.
%
%   Inputs:
%     elementType - integer scalar
%     functionSpaceType - string
%     tag - integer scalar (default -1)
%     returnCoord - logical scalar (default true)
%
%   Outputs:
%     typeKeys - row vector of int32
%     entityKeys - row vector of uint64
%     coord - row vector of doubles

    arguments
        elementType (1,1) {mustBeInteger}
        functionSpaceType (1,:) char
        tag (1,1) {mustBeInteger} = -1
        returnCoord (1,1) logical = true
    end

    [typeKeys, entityKeys, coord] = gmsh.internal.api.call('gmshModelMeshGetKeys', elementType, functionSpaceType, tag, returnCoord);
end
