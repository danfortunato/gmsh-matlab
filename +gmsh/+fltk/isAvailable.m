function ret = isAvailable()
%ISAVAILABLE  gmsh.fltk.isAvailable
%   Check if the user interface is available (e.g. to detect if it has been
%   closed).
%
%   Outputs:
%     ret - integer scalar

    ret = gmsh.internal.api.call('gmshFltkIsAvailable');
end
