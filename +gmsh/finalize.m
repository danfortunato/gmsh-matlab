function finalize()
%FINALIZE  gmsh.finalize
%   Finalize the Gmsh API. This must be called when you are done using the Gmsh
%   API.

    gmsh.internal.api.call('gmshFinalize');
end
