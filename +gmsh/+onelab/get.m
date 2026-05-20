function data = get(name, format)
%GET  gmsh.onelab.get
%   Get all the parameters (or a single one if `name' is specified) from the
%   ONELAB database, encoded in `format'.
%
%   Inputs:
%     name - string (default '')
%     format - string (default "json")
%
%   Outputs:
%     data - string

    arguments
        name (1,:) char = ''
        format (1,:) char = "json"
    end

    data = gmsh.internal.api.call('gmshOnelabGet', name, format);
end
