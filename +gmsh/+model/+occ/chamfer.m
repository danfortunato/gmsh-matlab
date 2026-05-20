function outDimTags = chamfer(volumeTags, curveTags, surfaceTags, distances, removeVolume)
%CHAMFER  gmsh.model.occ.chamfer
%   Chamfer the volumes `volumeTags' on the curves `curveTags' with distances
%   `distances' measured on surfaces `surfaceTags'. The `distances' vector can
%   either contain a single distance, as many distances as `curveTags' and
%   `surfaceTags', or twice as many as `curveTags' and `surfaceTags' (in which
%   case the first in each pair is measured on the corresponding surface in
%   `surfaceTags', the other on the other adjacent surface). Return the
%   chamfered entities in `outDimTags'. Remove the original volume if
%   `removeVolume' is set.
%
%   Inputs:
%     volumeTags - vector of integers
%     curveTags - vector of integers
%     surfaceTags - vector of integers
%     distances - vector of doubles
%     removeVolume - logical scalar (default true)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        volumeTags
        curveTags
        surfaceTags
        distances
        removeVolume (1,1) logical = true
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccChamfer', volumeTags, curveTags, surfaceTags, distances, removeVolume);
end
