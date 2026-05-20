function value = getNumber(tag, name)
%GETNUMBER  gmsh.view.option.getNumber
%   Get the `value' of the numerical option `name' for the view with tag `tag'.
%
%   Inputs:
%     tag - integer scalar
%     name - string
%
%   Outputs:
%     value - double scalar

    arguments
        tag (1,1) {mustBeInteger}
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshViewOptionGetNumber', tag, name);
end
