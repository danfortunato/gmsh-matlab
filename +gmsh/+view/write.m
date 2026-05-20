function write(tag, fileName, append)
%WRITE  gmsh.view.write
%   Write the view to a file `fileName'. The export format is determined by the
%   file extension. Append to the file if `append' is set.
%
%   Inputs:
%     tag - integer scalar
%     fileName - string
%     append - logical scalar (default false)

    arguments
        tag (1,1) {mustBeInteger}
        fileName (1,:) char
        append (1,1) logical = false
    end

    gmsh.internal.api.call('gmshViewWrite', tag, fileName, append);
end
