function remove(tag)
%REMOVE  gmsh.view.remove
%   Remove the view with tag `tag'.
%
%   Inputs:
%     tag - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshViewRemove', tag);
end
