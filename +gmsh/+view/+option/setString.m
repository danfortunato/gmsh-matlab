function setString(tag, name, value)
%SETSTRING  gmsh.view.option.setString
%   Set the string option `name' to value `value' for the view with tag `tag'.
%
%   Inputs:
%     tag - integer scalar
%     name - string
%     value - string

    arguments
        tag (1,1) {mustBeInteger}
        name (1,:) char
        value (1,:) char
    end

    gmsh.internal.api.call('gmshViewOptionSetString', tag, name, value);
end
