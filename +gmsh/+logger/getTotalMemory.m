function ret = getTotalMemory()
%GETTOTALMEMORY  gmsh.logger.getTotalMemory
%   Return total available memory (in Mb).
%
%   Outputs:
%     ret - double scalar

    ret = gmsh.internal.api.call('gmshLoggerGetTotalMemory');
end
