function ret = getCpuTime()
%GETCPUTIME  gmsh.logger.getCpuTime
%   Return CPU time (in s).
%
%   Outputs:
%     ret - double scalar

    ret = gmsh.internal.api.call('gmshLoggerGetCpuTime');
end
