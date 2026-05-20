function basisFunctionsOrientation = getBasisFunctionsOrientationForElement(elementTag, functionSpaceType)
%GETBASISFUNCTIONSORIENTATIONFORELEMENT  gmsh.model.mesh.getBasisFunctionsOrientationForElement
%   Get the orientation of a single element `elementTag'.
%
%   Inputs:
%     elementTag - size_t scalar
%     functionSpaceType - string
%
%   Outputs:
%     basisFunctionsOrientation - integer scalar

    arguments
        elementTag (1,1) {mustBeInteger, mustBeNonnegative}
        functionSpaceType (1,:) char
    end

    basisFunctionsOrientation = gmsh.internal.api.call('gmshModelMeshGetBasisFunctionsOrientationForElement', elementTag, functionSpaceType);
end
