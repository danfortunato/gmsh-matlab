function ret = getWallTime()
%GETWALLTIME  gmsh.logger.getWallTime
%   Return wall clock time (in s).
%
%   Outputs:
%     ret - double scalar

    ret = gmsh.internal.api.call('gmshLoggerGetWallTime');
end
