function outDimTags = getBoundary(dimTags, combined, oriented, recursive)
%GETBOUNDARY  gmsh.model.getBoundary
%   Get the boundary of the model entities `dimTags', given as a vector of (dim,
%   tag) pairs. Return in `outDimTags' the boundary of the individual entities
%   (if `combined' is false) or the boundary of the combined geometrical shape
%   formed by all input entities (if `combined' is true). Return tags multiplied
%   by the sign of the boundary entity if `oriented' is true. Apply the boundary
%   operator recursively down to dimension 0 (i.e. to points) if `recursive' is
%   true.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     combined - logical scalar (default true)
%     oriented - logical scalar (default false)
%     recursive - logical scalar (default false)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags
        combined (1,1) logical = true
        oriented (1,1) logical = false
        recursive (1,1) logical = false
    end

    outDimTags = gmsh.internal.api.call('gmshModelGetBoundary', dimTags, combined, oriented, recursive);
end
