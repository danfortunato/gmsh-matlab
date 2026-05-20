function ret = addSpline(pointTags, tag, tangents)
%ADDSPLINE  gmsh.model.occ.addSpline
%   Add a spline (C2 b-spline) curve in the OpenCASCADE CAD representation,
%   going through the points `pointTags'. If `tag' is positive, set the tag
%   explicitly; otherwise a new tag is selected automatically. Create a periodic
%   curve if the first and last points are the same. Return the tag of the
%   spline curve. If the `tangents' vector contains 6 entries, use them as
%   concatenated x, y, z components of the initial and final tangents of the
%   b-spline; if it contains 3 times as many entries as the number of points,
%   use them as concatenated x, y, z components of the tangents at each point,
%   unless the norm of the tangent is zero.
%
%   Inputs:
%     pointTags - vector of integers
%     tag - integer scalar (default -1)
%     tangents - vector of doubles (default [])
%
%   Outputs:
%     ret - integer scalar

    arguments
        pointTags
        tag (1,1) {mustBeInteger} = -1
        tangents = []
    end

    ret = gmsh.internal.api.call('gmshModelOccAddSpline', pointTags, tag, tangents);
end
