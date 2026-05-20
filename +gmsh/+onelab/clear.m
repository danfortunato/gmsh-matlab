function clear(name)
%CLEAR  gmsh.onelab.clear
%   Clear the ONELAB database, or remove a single parameter if `name' is given.
%
%   Inputs:
%     name - string (default '')

    arguments
        name (1,:) char = ''
    end

    gmsh.internal.api.call('gmshOnelabClear', name);
end
