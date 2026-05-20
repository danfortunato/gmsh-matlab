function unlock()
%UNLOCK  gmsh.fltk.unlock
%   Release the lock that was set using lock.

    gmsh.internal.api.call('gmshFltkUnlock');
end
