function [curveLoopTags, curveTags] = getCurveLoops(surfaceTag)
%GETCURVELOOPS  gmsh.model.occ.getCurveLoops
%   Get the tags `curveLoopTags' of the curve loops making up the surface of tag
%   `surfaceTag', as well as the tags `curveTags' of the curves making up each
%   curve loop.
%
%   Inputs:
%     surfaceTag - integer scalar
%
%   Outputs:
%     curveLoopTags - row vector of int32
%     curveTags - cell of int32 row vectors

    arguments
        surfaceTag (1,1) {mustBeInteger}
    end

    [curveLoopTags, curveTags] = gmsh.internal.api.call('gmshModelOccGetCurveLoops', surfaceTag);
end
