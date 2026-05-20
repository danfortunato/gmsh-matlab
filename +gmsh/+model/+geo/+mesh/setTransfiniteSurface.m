function setTransfiniteSurface(tag, arrangement, cornerTags)
%SETTRANSFINITESURFACE  gmsh.model.geo.mesh.setTransfiniteSurface
%   Set a transfinite meshing constraint on the surface `tag' in the built-in
%   CAD kernel representation. `arrangement' describes the arrangement of the
%   triangles when the surface is not flagged as recombined: currently supported
%   values are "Left", "Right", "AlternateLeft" and "AlternateRight".
%   `cornerTags' can be used to specify the (3 or 4) corners of the transfinite
%   interpolation explicitly; specifying the corners explicitly is mandatory if
%   the surface has more that 3 or 4 points on its boundary.
%
%   Inputs:
%     tag - integer scalar
%     arrangement - string (default "Left")
%     cornerTags - vector of integers (default int32([]))

    arguments
        tag (1,1) {mustBeInteger}
        arrangement (1,:) char = "Left"
        cornerTags = int32([])
    end

    gmsh.internal.api.call('gmshModelGeoMeshSetTransfiniteSurface', tag, arrangement, cornerTags);
end
