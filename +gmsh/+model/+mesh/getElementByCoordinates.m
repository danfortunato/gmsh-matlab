function [elementTag, elementType, nodeTags, u, v, w] = getElementByCoordinates(x, y, z, dim, strict)
%GETELEMENTBYCOORDINATES  gmsh.model.mesh.getElementByCoordinates
%   Search the mesh for an element located at coordinates (`x', `y', `z'). This
%   function performs a search in a spatial octree. If an element is found,
%   return its tag, type and node tags, as well as the local coordinates (`u',
%   `v', `w') within the reference element corresponding to search location. If
%   `dim' is >= 0, only search for elements of the given dimension. If `strict'
%   is not set, use a tolerance to find elements near the search location.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dim - integer scalar (default -1)
%     strict - logical scalar (default false)
%
%   Outputs:
%     elementTag - size_t scalar
%     elementType - integer scalar
%     nodeTags - row vector of uint64
%     u - double scalar
%     v - double scalar
%     w - double scalar

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        dim (1,1) {mustBeInteger} = -1
        strict (1,1) logical = false
    end

    [elementTag, elementType, nodeTags, u, v, w] = gmsh.internal.api.call('gmshModelMeshGetElementByCoordinates', x, y, z, dim, strict);
end
