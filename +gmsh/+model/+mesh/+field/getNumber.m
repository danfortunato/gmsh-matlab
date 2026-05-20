function value = getNumber(tag, option)
%GETNUMBER  gmsh.model.mesh.field.getNumber
%   Get the value of the numerical option `option' for field `tag'.
%
%   Inputs:
%     tag - integer scalar
%     option - string
%
%   Outputs:
%     value - double scalar

    arguments
        tag (1,1) {mustBeInteger}
        option (1,:) char
    end

    value = gmsh.internal.api.call('gmshModelMeshFieldGetNumber', tag, option);
end
