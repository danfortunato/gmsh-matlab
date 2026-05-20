function ret = isInitialized()
%ISINITIALIZED  gmsh.isInitialized
%   Return 1 if the Gmsh API is initialized, and 0 if not.
%
%   Outputs:
%     ret - integer scalar

    ret = gmsh.internal.api.call('gmshIsInitialized');
end
