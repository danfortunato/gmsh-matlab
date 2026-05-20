function [elementType, nodeTags, dim, tag] = getElement(elementTag)
%GETELEMENT  gmsh.model.mesh.getElement
%   Get the type and node tags of the element with tag `elementTag', as well as
%   the dimension `dim' and tag `tag' of the entity on which the element is
%   classified. This function relies on an internal cache (a vector in case of
%   dense element numbering, a map otherwise); for large meshes accessing
%   elements in bulk is often preferable.
%
%   Inputs:
%     elementTag - size_t scalar
%
%   Outputs:
%     elementType - integer scalar
%     nodeTags - row vector of uint64
%     dim - integer scalar
%     tag - integer scalar

    arguments
        elementTag (1,1) {mustBeInteger, mustBeNonnegative}
    end

    [elementType, nodeTags, dim, tag] = gmsh.internal.api.call('gmshModelMeshGetElement', elementTag);
end
