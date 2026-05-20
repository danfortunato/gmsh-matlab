function ret = getMemory()
%GETMEMORY  gmsh.logger.getMemory
%   Return memory usage (in Mb).
%
%   Outputs:
%     ret - double scalar

    ret = gmsh.internal.api.call('gmshLoggerGetMemory');
end
