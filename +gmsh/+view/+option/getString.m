function value = getString(tag, name)
%GETSTRING  gmsh.view.option.getString
%   Get the `value' of the string option `name' for the view with tag `tag'.
%
%   Inputs:
%     tag - integer scalar
%     name - string
%
%   Outputs:
%     value - string

    arguments
        tag (1,1) {mustBeInteger}
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshViewOptionGetString', tag, name);
end
