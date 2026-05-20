function setNumber(tag, name, value)
%SETNUMBER  gmsh.view.option.setNumber
%   Set the numerical option `name' to value `value' for the view with tag
%   `tag'.
%
%   Inputs:
%     tag - integer scalar
%     name - string
%     value - double scalar

    arguments
        tag (1,1) {mustBeInteger}
        name (1,:) char
        value (1,1) double
    end

    gmsh.internal.api.call('gmshViewOptionSetNumber', tag, name, value);
end
