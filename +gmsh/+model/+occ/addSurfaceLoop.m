function ret = addSurfaceLoop(surfaceTags, tag, sewing)
%ADDSURFACELOOP  gmsh.model.occ.addSurfaceLoop
%   Add a surface loop (a closed shell) in the OpenCASCADE CAD representation,
%   formed by `surfaceTags'.  If `tag' is positive, set the tag explicitly;
%   otherwise a new tag is selected automatically. Return the tag of the surface
%   loop. Setting `sewing' allows one to build a shell made of surfaces that
%   share geometrically identical (but topologically different) curves.
%
%   Inputs:
%     surfaceTags - vector of integers
%     tag - integer scalar (default -1)
%     sewing - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        surfaceTags
        tag (1,1) {mustBeInteger} = -1
        sewing (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelOccAddSurfaceLoop', surfaceTags, tag, sewing);
end
