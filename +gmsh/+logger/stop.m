function stop()
%STOP  gmsh.logger.stop
%   Stop logging messages.

    gmsh.internal.api.call('gmshLoggerStop');
end
