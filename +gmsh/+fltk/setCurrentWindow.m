function setCurrentWindow(windowIndex)
%SETCURRENTWINDOW  gmsh.fltk.setCurrentWindow
%   Set the current window by speficying its index (starting at 0) in the list
%   of all windows. When new windows are created by splits, new windows are
%   appended at the end of the list.
%
%   Inputs:
%     windowIndex - integer scalar (default 0)

    arguments
        windowIndex (1,1) {mustBeInteger} = 0
    end

    gmsh.internal.api.call('gmshFltkSetCurrentWindow', windowIndex);
end
