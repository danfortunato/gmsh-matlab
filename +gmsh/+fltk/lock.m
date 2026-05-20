function lock()
%LOCK  gmsh.fltk.lock
%   Block the current thread until it can safely modify the user interface.

    gmsh.internal.api.call('gmshFltkLock');
end
