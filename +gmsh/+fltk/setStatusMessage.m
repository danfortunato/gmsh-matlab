function setStatusMessage(message, graphics)
%SETSTATUSMESSAGE  gmsh.fltk.setStatusMessage
%   Set a status message in the current window. If `graphics' is set, display
%   the message inside the graphic window instead of the status bar.
%
%   Inputs:
%     message - string
%     graphics - logical scalar (default false)

    arguments
        message (1,:) char
        graphics (1,1) logical = false
    end

    gmsh.internal.api.call('gmshFltkSetStatusMessage', message, graphics);
end
