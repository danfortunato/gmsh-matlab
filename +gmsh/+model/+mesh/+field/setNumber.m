function setNumber(tag, option, value)
%SETNUMBER  gmsh.model.mesh.field.setNumber
%   Set the numerical option `option' to value `value' for field `tag'.
%
%   Inputs:
%     tag - integer scalar
%     option - string
%     value - double scalar

    arguments
        tag (1,1) {mustBeInteger}
        option (1,:) char
        value (1,1) double
    end

    gmsh.internal.api.call('gmshModelMeshFieldSetNumber', tag, option, value);
end
