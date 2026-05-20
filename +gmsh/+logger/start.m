function start()
%START  gmsh.logger.start
%   Start logging messages.

    gmsh.internal.api.call('gmshLoggerStart');
end
