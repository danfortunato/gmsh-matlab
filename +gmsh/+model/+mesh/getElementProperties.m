function [elementName, dim, order, numNodes, localNodeCoord, numPrimaryNodes] = getElementProperties(elementType)
%GETELEMENTPROPERTIES  gmsh.model.mesh.getElementProperties
%   Get the properties of an element of type `elementType': its name
%   (`elementName'), dimension (`dim'), order (`order'), number of nodes
%   (`numNodes'), local coordinates of the nodes in the reference element
%   (`localNodeCoord' vector, of length `dim' times `numNodes') and number of
%   primary (first order) nodes (`numPrimaryNodes').
%
%   Inputs:
%     elementType - integer scalar
%
%   Outputs:
%     elementName - string
%     dim - integer scalar
%     order - integer scalar
%     numNodes - integer scalar
%     localNodeCoord - row vector of doubles
%     numPrimaryNodes - integer scalar

    arguments
        elementType (1,1) {mustBeInteger}
    end

    [elementName, dim, order, numNodes, localNodeCoord, numPrimaryNodes] = gmsh.internal.api.call('gmshModelMeshGetElementProperties', elementType);
end
