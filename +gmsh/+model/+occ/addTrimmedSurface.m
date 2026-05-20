function ret = addTrimmedSurface(surfaceTag, wireTags, wire3D, tag)
%ADDTRIMMEDSURFACE  gmsh.model.occ.addTrimmedSurface
%   Trim the surface `surfaceTag' with the wires `wireTags', replacing any
%   existing trimming curves. The first wire defines the external contour, the
%   others define holes. If `wire3D' is set, consider wire curves as 3D curves
%   and project them on the surface; otherwise consider the wire curves as
%   defined in the parametric space of the surface. If `tag' is positive, set
%   the tag explicitly; otherwise a new tag is selected automatically. Return
%   the tag of the trimmed surface.
%
%   Inputs:
%     surfaceTag - integer scalar
%     wireTags - vector of integers (default int32([]))
%     wire3D - logical scalar (default false)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        surfaceTag (1,1) {mustBeInteger}
        wireTags = int32([])
        wire3D (1,1) logical = false
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelOccAddTrimmedSurface', surfaceTag, wireTags, wire3D, tag);
end
