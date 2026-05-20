function tags = getTags()
%GETTAGS  gmsh.view.getTags
%   Get the tags of all views.
%
%   Outputs:
%     tags - row vector of int32

    tags = gmsh.internal.api.call('gmshViewGetTags');
end
