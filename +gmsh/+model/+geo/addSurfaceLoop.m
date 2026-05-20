function ret = addSurfaceLoop(surfaceTags, tag)
%ADDSURFACELOOP  gmsh.model.geo.addSurfaceLoop
%   Add a surface loop (a closed shell) formed by `surfaceTags' in the built-in
%   CAD representation.  If `tag' is positive, set the tag explicitly; otherwise
%   a new tag is selected automatically. Return the tag of the shell.
%
%   Inputs:
%     surfaceTags - vector of integers
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        surfaceTags
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddSurfaceLoop', surfaceTags, tag);
end
