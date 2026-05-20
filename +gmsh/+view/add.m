function ret = add(name, tag)
%ADD  gmsh.view.add
%   Add a new post-processing view, with name `name'. If `tag' is positive use
%   it (and remove the view with that tag if it already exists), otherwise
%   associate a new tag. Return the view tag.
%
%   Inputs:
%     name - string
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        name (1,:) char
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshViewAdd', name, tag);
end
