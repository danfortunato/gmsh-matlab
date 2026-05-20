function ret = getNumberOfKeys(elementType, functionSpaceType)
%GETNUMBEROFKEYS  gmsh.model.mesh.getNumberOfKeys
%   Get the number of keys by elements of type `elementType' for function space
%   named `functionSpaceType'.
%
%   Inputs:
%     elementType - integer scalar
%     functionSpaceType - string
%
%   Outputs:
%     ret - integer scalar

    arguments
        elementType (1,1) {mustBeInteger}
        functionSpaceType (1,:) char
    end

    ret = gmsh.internal.api.call('gmshModelMeshGetNumberOfKeys', elementType, functionSpaceType);
end
