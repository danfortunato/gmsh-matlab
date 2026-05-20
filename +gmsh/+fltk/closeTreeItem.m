function closeTreeItem(name)
%CLOSETREEITEM  gmsh.fltk.closeTreeItem
%   Close the `name' item in the menu tree.
%
%   Inputs:
%     name - string

    arguments
        name (1,:) char
    end

    gmsh.internal.api.call('gmshFltkCloseTreeItem', name);
end
