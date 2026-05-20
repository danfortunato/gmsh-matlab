function outDimTags = addThickSolid(volumeTag, excludeSurfaceTags, offset, tag)
%ADDTHICKSOLID  gmsh.model.occ.addThickSolid
%   Add a hollowed volume in the OpenCASCADE CAD representation, built from an
%   initial volume `volumeTag' and a set of faces from this volume
%   `excludeSurfaceTags', which are to be removed. The remaining faces of the
%   volume become the walls of the hollowed solid, with thickness `offset'. If
%   `tag' is positive, set the tag explicitly; otherwise a new tag is selected
%   automatically.
%
%   Inputs:
%     volumeTag - integer scalar
%     excludeSurfaceTags - vector of integers
%     offset - double scalar
%     tag - integer scalar (default -1)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        volumeTag (1,1) {mustBeInteger}
        excludeSurfaceTags
        offset (1,1) double
        tag (1,1) {mustBeInteger} = -1
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccAddThickSolid', volumeTag, excludeSurfaceTags, offset, tag);
end
