function names = getNames(search)
%GETNAMES  gmsh.onelab.getNames
%   Get the names of the parameters in the ONELAB database matching the `search'
%   regular expression. If `search' is empty, return all the names.
%
%   Inputs:
%     search - string (default '')
%
%   Outputs:
%     names - cell of strings

    arguments
        search (1,:) char = ''
    end

    names = gmsh.internal.api.call('gmshOnelabGetNames', search);
end
