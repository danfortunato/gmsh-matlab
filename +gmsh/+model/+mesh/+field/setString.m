function setString(tag, option, value)
%SETSTRING  gmsh.model.mesh.field.setString
%   Set the string option `option' to value `value' for field `tag'.
%
%   Inputs:
%     tag - integer scalar
%     option - string
%     value - string

    arguments
        tag (1,1) {mustBeInteger}
        option (1,:) char
        value (1,:) char
    end

    gmsh.internal.api.call('gmshModelMeshFieldSetString', tag, option, value);
end
