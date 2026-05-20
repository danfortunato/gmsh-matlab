function splitCurrentWindow(how, ratio)
%SPLITCURRENTWINDOW  gmsh.fltk.splitCurrentWindow
%   Split the current window horizontally (if `how' == "h") or vertically (if
%   `how' == "v"), using ratio `ratio'. If `how' == "u", restore a single
%   window.
%
%   Inputs:
%     how - string (default "v")
%     ratio - double scalar (default 0.5)

    arguments
        how (1,:) char = "v"
        ratio (1,1) double = 0.5
    end

    gmsh.internal.api.call('gmshFltkSplitCurrentWindow', how, ratio);
end
