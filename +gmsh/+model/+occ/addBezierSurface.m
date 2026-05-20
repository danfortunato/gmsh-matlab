function ret = addBezierSurface(pointTags, numPointsU, tag, wireTags, wire3D)
%ADDBEZIERSURFACE  gmsh.model.occ.addBezierSurface
%   Add a Bezier surface in the OpenCASCADE CAD representation, with `pointTags'
%   control points given as a single vector [Pu1v1, ... Pu`numPointsU'v1, Pu1v2,
%   ...]. If `tag' is positive, set the tag explicitly; otherwise a new tag is
%   selected automatically. If `wireTags' is provided, trim the Bezier patch
%   using the provided wires: the first wire defines the external contour, the
%   others define holes. If `wire3D' is set, consider wire curves as 3D curves
%   and project them on the Bezier surface; otherwise consider the wire curves
%   as defined in the parametric space of the surface. Return the tag of the
%   Bezier surface.
%
%   Inputs:
%     pointTags - vector of integers
%     numPointsU - integer scalar
%     tag - integer scalar (default -1)
%     wireTags - vector of integers (default int32([]))
%     wire3D - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        pointTags
        numPointsU (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        wireTags = int32([])
        wire3D (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelOccAddBezierSurface', pointTags, numPointsU, tag, wireTags, wire3D);
end
