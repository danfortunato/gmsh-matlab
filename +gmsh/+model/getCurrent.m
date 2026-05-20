function name = getCurrent()
%GETCURRENT  gmsh.model.getCurrent
%   Get the name of the current model.
%
%   Outputs:
%     name - string

    name = gmsh.internal.api.call('gmshModelGetCurrent');
end
