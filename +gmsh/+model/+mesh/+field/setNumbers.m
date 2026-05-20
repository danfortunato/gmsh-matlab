function setNumbers(tag, option, values)
%SETNUMBERS  gmsh.model.mesh.field.setNumbers
%   Set the numerical list option `option' to value `values' for field `tag'.
%
%   Inputs:
%     tag - integer scalar
%     option - string
%     values - vector of doubles

    arguments
        tag (1,1) {mustBeInteger}
        option (1,:) char
        values
    end

    gmsh.internal.api.call('gmshModelMeshFieldSetNumbers', tag, option, values);
end
