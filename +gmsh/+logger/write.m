function write(message, level)
%WRITE  gmsh.logger.write
%   Write a `message'. `level' can be "info", "warning" or "error".
%
%   Inputs:
%     message - string
%     level - string (default "info")

    arguments
        message (1,:) char
        level (1,:) char = "info"
    end

    gmsh.internal.api.call('gmshLoggerWrite', message, level);
end
