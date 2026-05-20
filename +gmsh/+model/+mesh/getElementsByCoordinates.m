function elementTags = getElementsByCoordinates(x, y, z, dim, strict)
%GETELEMENTSBYCOORDINATES  gmsh.model.mesh.getElementsByCoordinates
%   Search the mesh for element(s) located at coordinates (`x', `y', `z'). This
%   function performs a search in a spatial octree. Return the tags of all found
%   elements in `elementTags'. Additional information about the elements can be
%   accessed through `getElement' and `getLocalCoordinatesInElement'. If `dim'
%   is >= 0, only search for elements of the given dimension. If `strict' is not
%   set, use a tolerance to find elements near the search location.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dim - integer scalar (default -1)
%     strict - logical scalar (default false)
%
%   Outputs:
%     elementTags - row vector of uint64

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        dim (1,1) {mustBeInteger} = -1
        strict (1,1) logical = false
    end

    elementTags = gmsh.internal.api.call('gmshModelMeshGetElementsByCoordinates', x, y, z, dim, strict);
end
