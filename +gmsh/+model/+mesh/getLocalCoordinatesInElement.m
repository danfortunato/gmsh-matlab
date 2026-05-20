function [u, v, w] = getLocalCoordinatesInElement(elementTag, x, y, z)
%GETLOCALCOORDINATESINELEMENT  gmsh.model.mesh.getLocalCoordinatesInElement
%   Return the local coordinates (`u', `v', `w') within the element `elementTag'
%   corresponding to the model coordinates (`x', `y', `z'). This function relies
%   on an internal cache (a vector in case of dense element numbering, a map
%   otherwise); for large meshes accessing elements in bulk is often preferable.
%
%   Inputs:
%     elementTag - size_t scalar
%     x - double scalar
%     y - double scalar
%     z - double scalar
%
%   Outputs:
%     u - double scalar
%     v - double scalar
%     w - double scalar

    arguments
        elementTag (1,1) {mustBeInteger, mustBeNonnegative}
        x (1,1) double
        y (1,1) double
        z (1,1) double
    end

    [u, v, w] = gmsh.internal.api.call('gmshModelMeshGetLocalCoordinatesInElement', elementTag, x, y, z);
end
