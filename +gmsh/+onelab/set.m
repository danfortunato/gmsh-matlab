function set(data, format)
%SET  gmsh.onelab.set
%   Set one or more parameters in the ONELAB database, encoded in `format'.
%
%   Inputs:
%     data - string
%     format - string (default "json")

    arguments
        data (1,:) char
        format (1,:) char = "json"
    end

    gmsh.internal.api.call('gmshOnelabSet', data, format);
end
