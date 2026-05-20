function log = get()
%GET  gmsh.logger.get
%   Get logged messages.
%
%   Outputs:
%     log - cell of strings

    log = gmsh.internal.api.call('gmshLoggerGet');
end
