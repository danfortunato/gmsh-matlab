function values = getNumbers(tag, option)
%GETNUMBERS  gmsh.model.mesh.field.getNumbers
%   Get the value of the numerical list option `option' for field `tag'.
%
%   Inputs:
%     tag - integer scalar
%     option - string
%
%   Outputs:
%     values - row vector of doubles

    arguments
        tag (1,1) {mustBeInteger}
        option (1,:) char
    end

    values = gmsh.internal.api.call('gmshModelMeshFieldGetNumbers', tag, option);
end
