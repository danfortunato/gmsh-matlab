function clear()
%CLEAR  gmsh.clear
%   Clear all loaded models and post-processing data, and add a new empty model.

    gmsh.internal.api.call('gmshClear');
end
