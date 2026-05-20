function [surfaceLoopTags, surfaceTags] = getSurfaceLoops(volumeTag)
%GETSURFACELOOPS  gmsh.model.occ.getSurfaceLoops
%   Get the tags `surfaceLoopTags' of the surface loops making up the volume of
%   tag `volumeTag', as well as the tags `surfaceTags' of the surfaces making up
%   each surface loop.
%
%   Inputs:
%     volumeTag - integer scalar
%
%   Outputs:
%     surfaceLoopTags - row vector of int32
%     surfaceTags - cell of int32 row vectors

    arguments
        volumeTag (1,1) {mustBeInteger}
    end

    [surfaceLoopTags, surfaceTags] = gmsh.internal.api.call('gmshModelOccGetSurfaceLoops', volumeTag);
end
