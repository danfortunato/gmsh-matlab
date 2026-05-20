function ret = getChanged(name)
%GETCHANGED  gmsh.onelab.getChanged
%   Check if any parameters in the ONELAB database used by the client `name'
%   have been changed.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     ret - integer scalar

    arguments
        name (1,:) char
    end

    ret = gmsh.internal.api.call('gmshOnelabGetChanged', name);
end
