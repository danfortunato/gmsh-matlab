function [outDimTags, outDimTagsMap] = fuse(objectDimTags, toolDimTags, tag, removeObject, removeTool)
%FUSE  gmsh.model.occ.fuse
%   Compute the boolean union (the fusion) of the entities `objectDimTags' and
%   `toolDimTags' (vectors of (dim, tag) pairs) in the OpenCASCADE CAD
%   representation. Return the resulting entities in `outDimTags', and the
%   correspondance between input and resulting entities in `outDimTagsMap'. If
%   `tag' is positive, try to set the tag explicitly (only valid if the boolean
%   operation results in a single entity). Remove the object if `removeObject'
%   is set. Remove the tool if `removeTool' is set.
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

    [outDimTags, outDimTagsMap] = gmsh.internal.api.call('gmshModelOccFuse', objectDimTags, toolDimTags, tag, removeObject, removeTool);
end
