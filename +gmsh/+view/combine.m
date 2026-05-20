function combine(what, how, remove, copyOptions)
%COMBINE  gmsh.view.combine
%   Combine elements (if `what' == "elements") or steps (if `what' == "steps")
%   of all views (`how' == "all"), all visible views (`how' == "visible") or all
%   views having the same name (`how' == "name"). Remove original views if
%   `remove' is set.
%
%   Inputs:
%     what - string
%     how - string
%     remove - logical scalar (default true)
%     copyOptions - logical scalar (default true)

    arguments
        what (1,:) char
        how (1,:) char
        remove (1,1) logical = true
        copyOptions (1,1) logical = true
    end

    gmsh.internal.api.call('gmshViewCombine', what, how, remove, copyOptions);
end
