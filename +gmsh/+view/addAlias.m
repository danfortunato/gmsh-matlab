function ret = addAlias(refTag, copyOptions, tag)
%ADDALIAS  gmsh.view.addAlias
%   Add a post-processing view as an `alias' of the reference view with tag
%   `refTag'. If `copyOptions' is set, copy the options of the reference view.
%   If `tag' is positive use it (and remove the view with that tag if it already
%   exists), otherwise associate a new tag. Return the view tag.
%
%   Inputs:
%     refTag - integer scalar
%     copyOptions - logical scalar (default false)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        refTag (1,1) {mustBeInteger}
        copyOptions (1,1) logical = false
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshViewAddAlias', refTag, copyOptions, tag);
end
