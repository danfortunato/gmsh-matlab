function value = getString(tag, option)
%GETSTRING  gmsh.model.mesh.field.getString
%   Get the value of the string option `option' for field `tag'.
%
%   Inputs:
%     tag - integer scalar
%     option - string
%
%   Outputs:
%     value - string

    arguments
        tag (1,1) {mustBeInteger}
        option (1,:) char
    end

    value = gmsh.internal.api.call('gmshModelMeshFieldGetString', tag, option);
end
