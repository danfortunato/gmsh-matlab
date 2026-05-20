function setChanged(name, value)
%SETCHANGED  gmsh.onelab.setChanged
%   Set the changed flag to value `value' for all the parameters in the ONELAB
%   database used by the client `name'.
%
%   Inputs:
%     name - string
%     value - integer scalar

    arguments
        name (1,:) char
        value (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshOnelabSetChanged', name, value);
end
