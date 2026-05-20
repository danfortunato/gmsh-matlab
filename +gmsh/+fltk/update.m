function update()
%UPDATE  gmsh.fltk.update
%   Update the user interface (potentially creating new widgets and windows).
%   First automatically create the user interface if it has not yet been
%   initialized. Can only be called in the main thread: use `awake("update")' to
%   trigger an update of the user interface from another thread.

    gmsh.internal.api.call('gmshFltkUpdate');
end
