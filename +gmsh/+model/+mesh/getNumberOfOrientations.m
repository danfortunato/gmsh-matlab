function ret = getNumberOfOrientations(elementType, functionSpaceType)
%GETNUMBEROFORIENTATIONS  gmsh.model.mesh.getNumberOfOrientations
%   Get the number of possible orientations for elements of type `elementType'
%   and function space named `functionSpaceType'.
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

    ret = gmsh.internal.api.call('gmshModelMeshGetNumberOfOrientations', elementType, functionSpaceType);
end
