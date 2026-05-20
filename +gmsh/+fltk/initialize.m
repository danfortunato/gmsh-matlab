function initialize()
%INITIALIZE  gmsh.fltk.initialize
%   Create the FLTK graphical user interface. Can only be called in the main
%   thread.

    gmsh.internal.api.call('gmshFltkInitialize');
end
