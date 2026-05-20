function openTreeItem(name)
%OPENTREEITEM  gmsh.fltk.openTreeItem
%   Open the `name' item in the menu tree.
%
%   Inputs:
%     name - string

    arguments
        name (1,:) char
    end

    gmsh.internal.api.call('gmshFltkOpenTreeItem', name);
end
