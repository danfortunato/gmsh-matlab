function ret = getIndex(tag)
%GETINDEX  gmsh.view.getIndex
%   Get the index of the view with tag `tag' in the list of currently loaded
%   views. This dynamic index (it can change when views are removed) is used to
%   access view options.
%
%   Inputs:
%     tag - integer scalar
%
%   Outputs:
%     ret - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
    end

    ret = gmsh.internal.api.call('gmshViewGetIndex', tag);
end
