function [outDimTags, outDimTagsMap] = fragment(objectDimTags, toolDimTags, tag, removeObject, removeTool)
%FRAGMENT  gmsh.model.occ.fragment
%   Compute the boolean fragments (general fuse) resulting from the intersection
%   of the entities `objectDimTags' and `toolDimTags' (given as vectors of (dim,
%   tag) pairs) in the OpenCASCADE CAD representation, making all interfaces
%   conformal. When applied to entities of different dimensions, the lower
%   dimensional entities will be automatically embedded in the higher
%   dimensional entities if they are not on their boundary. Return the resulting
%   entities in `outDimTags', and the correspondance between input and resulting
%   entities in `outDimTagsMap'. If `tag' is positive, try to set the tag
%   explicitly (only valid if the boolean operation results in a single entity).
%   Remove the object if `removeObject' is set. Remove the tool if `removeTool'
%   is set.
%
%   Inputs:
%     objectDimTags - Nx2 matrix of (dim,tag)
%     toolDimTags - Nx2 matrix of (dim,tag)
%     tag - integer scalar (default -1)
%     removeObject - logical scalar (default true)
%     removeTool - logical scalar (default true)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs
%     outDimTagsMap - cell of Nx2 (dim,tag) matrices

    arguments
        objectDimTags
        toolDimTags
        tag (1,1) {mustBeInteger} = -1
        removeObject (1,1) logical = true
        removeTool (1,1) logical = true
    end

    [outDimTags, outDimTagsMap] = gmsh.internal.api.call('gmshModelOccFragment', objectDimTags, toolDimTags, tag, removeObject, removeTool);
end
