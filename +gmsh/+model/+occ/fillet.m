function outDimTags = fillet(volumeTags, curveTags, radii, removeVolume)
%FILLET  gmsh.model.occ.fillet
%   Fillet the volumes `volumeTags' on the curves `curveTags' with radii
%   `radii'. The `radii' vector can either contain a single radius, as many
%   radii as `curveTags', or twice as many as `curveTags' (in which case
%   different radii are provided for the begin and end points of the curves).
%   Return the filleted entities in `outDimTags' as a vector of (dim, tag)
%   pairs. Remove the original volume if `removeVolume' is set.
%
%   Inputs:
%     volumeTags - vector of integers
%     curveTags - vector of integers
%     radii - vector of doubles
%     removeVolume - logical scalar (default true)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        volumeTags
        curveTags
        radii
        removeVolume (1,1) logical = true
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccFillet', volumeTags, curveTags, radii, removeVolume);
end
