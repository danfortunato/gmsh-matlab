function setVisibilityPerWindow(tag, value, windowIndex)
%SETVISIBILITYPERWINDOW  gmsh.view.setVisibilityPerWindow
%   Set the global visibility of the view `tag' per window to `value', where
%   `windowIndex' identifies the window in the window list.
%
%   Inputs:
%     tag - integer scalar
%     value - integer scalar
%     windowIndex - integer scalar (default 0)

    arguments
        tag (1,1) {mustBeInteger}
        value (1,1) {mustBeInteger}
        windowIndex (1,1) {mustBeInteger} = 0
    end

    gmsh.internal.api.call('gmshViewSetVisibilityPerWindow', tag, value, windowIndex);
end
