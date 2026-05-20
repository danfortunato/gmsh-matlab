function outDimTags = defeature(volumeTags, surfaceTags, removeVolume)
%DEFEATURE  gmsh.model.occ.defeature
%   Defeature the volumes `volumeTags' by removing the surfaces `surfaceTags'.
%   Return the defeatured entities in `outDimTags'. Remove the original volume
%   if `removeVolume' is set.
%
%   Inputs:
%     volumeTags - vector of integers
%     surfaceTags - vector of integers
%     removeVolume - logical scalar (default true)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        volumeTags
        surfaceTags
        removeVolume (1,1) logical = true
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccDefeature', volumeTags, surfaceTags, removeVolume);
end
