function addListDataString(tag, coord, data, style)
%ADDLISTDATASTRING  gmsh.view.addListDataString
%   Add a string to a list-based post-processing view with tag `tag'. If `coord'
%   contains 3 coordinates the string is positioned in the 3D model space ("3D
%   string"); if it contains 2 coordinates it is positioned in the 2D graphics
%   viewport ("2D string"). `data' contains one or more (for multistep views)
%   strings. `style' contains key-value pairs of styling parameters,
%   concatenated. Available keys are "Font" (possible values: "Times-Roman",
%   "Times-Bold", "Times-Italic", "Times-BoldItalic", "Helvetica", "Helvetica-
%   Bold", "Helvetica-Oblique", "Helvetica-BoldOblique", "Courier", "Courier-
%   Bold", "Courier-Oblique", "Courier-BoldOblique", "Symbol", "ZapfDingbats",
%   "Screen"), "FontSize" and "Align" (possible values: "Left" or "BottomLeft",
%   "Center" or "BottomCenter", "Right" or "BottomRight", "TopLeft",
%   "TopCenter", "TopRight", "CenterLeft", "CenterCenter", "CenterRight").
%
%   Inputs:
%     tag - integer scalar
%     coord - vector of doubles
%     data - cell of strings
%     style - cell of strings (default {})

    arguments
        tag (1,1) {mustBeInteger}
        coord
        data
        style = {}
    end

    gmsh.internal.api.call('gmshViewAddListDataString', tag, coord, data, style);
end
