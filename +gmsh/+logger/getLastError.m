function errMsg = getLastError()
%GETLASTERROR  gmsh.logger.getLastError
%   Return last error message, if any.
%
%   Outputs:
%     errMsg - string

    errMsg = gmsh.internal.api.call('gmshLoggerGetLastError');
end
