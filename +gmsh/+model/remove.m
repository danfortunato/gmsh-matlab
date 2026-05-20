function remove()
%REMOVE  gmsh.model.remove
%   Remove the current model.

    gmsh.internal.api.call('gmshModelRemove');
end
