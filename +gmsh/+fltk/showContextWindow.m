function showContextWindow(dim, tag)
%SHOWCONTEXTWINDOW  gmsh.fltk.showContextWindow
%   Show context window for the entity of dimension `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshFltkShowContextWindow', dim, tag);
end
