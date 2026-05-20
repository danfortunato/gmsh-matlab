function setCurrent(name)
%SETCURRENT  gmsh.model.setCurrent
%   Set the current model to the model with name `name'. If several models have
%   the same name, select the one that was added first.
%
%   Inputs:
%     name - string

    arguments
        name (1,:) char
    end

    gmsh.internal.api.call('gmshModelSetCurrent', name);
end
