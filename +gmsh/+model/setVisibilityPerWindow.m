function setVisibilityPerWindow(value, windowIndex)
%SETVISIBILITYPERWINDOW  gmsh.model.setVisibilityPerWindow
%   Set the global visibility of the model per window to `value', where
%   `windowIndex' identifies the window in the window list.
%
%   Inputs:
%     value - integer scalar
%     windowIndex - integer scalar (default 0)

    arguments
        value (1,1) {mustBeInteger}
        windowIndex (1,1) {mustBeInteger} = 0
    end

    gmsh.internal.api.call('gmshModelSetVisibilityPerWindow', value, windowIndex);
end
