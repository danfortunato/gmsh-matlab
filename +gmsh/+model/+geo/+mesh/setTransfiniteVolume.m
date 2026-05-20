function setTransfiniteVolume(tag, cornerTags)
%SETTRANSFINITEVOLUME  gmsh.model.geo.mesh.setTransfiniteVolume
%   Set a transfinite meshing constraint on the surface `tag' in the built-in
%   CAD kernel representation. `cornerTags' can be used to specify the (6 or 8)
%   corners of the transfinite interpolation explicitly.
%
%   Inputs:
%     tag - integer scalar
%     cornerTags - vector of integers (default int32([]))

    arguments
        tag (1,1) {mustBeInteger}
        cornerTags = int32([])
    end

    gmsh.internal.api.call('gmshModelGeoMeshSetTransfiniteVolume', tag, cornerTags);
end
