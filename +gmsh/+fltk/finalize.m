function finalize()
%FINALIZE  gmsh.fltk.finalize
%   Close the FLTK graphical user interface. Can only be called in the main
%   thread.

    gmsh.internal.api.call('gmshFltkFinalize');
end
