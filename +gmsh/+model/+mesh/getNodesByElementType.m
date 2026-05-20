function [nodeTags, coord, parametricCoord] = getNodesByElementType(elementType, tag, returnParametricCoord)
%GETNODESBYELEMENTTYPE  gmsh.model.mesh.getNodesByElementType
%   Get the nodes classified on the entity of tag `tag', for all the elements of
%   type `elementType'. The other arguments are treated as in `getNodes'.
%
%   Inputs:
%     elementType - integer scalar
%     tag - integer scalar (default -1)
%     returnParametricCoord - logical scalar (default true)
%
%   Outputs:
%     nodeTags - row vector of uint64
%     coord - row vector of doubles
%     parametricCoord - row vector of doubles

    arguments
        elementType (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        returnParametricCoord (1,1) logical = true
    end

    [nodeTags, coord, parametricCoord] = gmsh.internal.api.call('gmshModelMeshGetNodesByElementType', elementType, tag, returnParametricCoord);
end
