function [coord, data, style] = getListDataStrings(tag, dim)
%GETLISTDATASTRINGS  gmsh.view.getListDataStrings
%   Get list-based post-processing data strings (2D strings if `dim' == 2, 3D
%   strings if `dim' = 3) from the view with tag `tag'. Return the coordinates
%   in `coord', the strings in `data' and the styles in `style'.
%
%   Inputs:
%     tag - integer scalar
%     dim - integer scalar
%
%   Outputs:
%     coord - row vector of doubles
%     data - cell of strings
%     style - cell of strings

    arguments
        tag (1,1) {mustBeInteger}
        dim (1,1) {mustBeInteger}
    end

    [coord, data, style] = gmsh.internal.api.call('gmshViewGetListDataStrings', tag, dim);
end
