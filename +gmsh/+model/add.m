function add(name)
%ADD  gmsh.model.add
%   Add a new model, with name `name', and set it as the current model.
%
%   Inputs:
%     name - string

    arguments
        name (1,:) char
    end

    gmsh.internal.api.call('gmshModelAdd', name);
end
