function ret = addBSplineSurface(pointTags, numPointsU, tag, degreeU, degreeV, weights, knotsU, knotsV, multiplicitiesU, multiplicitiesV, wireTags, wire3D)
%ADDBSPLINESURFACE  gmsh.model.occ.addBSplineSurface
%   Add a b-spline surface of degree `degreeU' x `degreeV' in the OpenCASCADE
%   CAD representation, with `pointTags' control points given as a single vector
%   [Pu1v1, ... Pu`numPointsU'v1, Pu1v2, ...]. If `weights', `knotsU', `knotsV',
%   `multiplicitiesU' or `multiplicitiesV' are not provided, default parameters
%   are computed automatically. If `tag' is positive, set the tag explicitly;
%   otherwise a new tag is selected automatically. If `wireTags' is provided,
%   trim the b-spline patch using the provided wires: the first wire defines the
%   external contour, the others define holes. If `wire3D' is set, consider wire
%   curves as 3D curves and project them on the b-spline surface; otherwise
%   consider the wire curves as defined in the parametric space of the surface.
%   Return the tag of the b-spline surface.
%
%   Inputs:
%     pointTags - vector of integers
%     numPointsU - integer scalar
%     tag - integer scalar (default -1)
%     degreeU - integer scalar (default 3)
%     degreeV - integer scalar (default 3)
%     weights - vector of doubles (default [])
%     knotsU - vector of doubles (default [])
%     knotsV - vector of doubles (default [])
%     multiplicitiesU - vector of integers (default int32([]))
%     multiplicitiesV - vector of integers (default int32([]))
%     wireTags - vector of integers (default int32([]))
%     wire3D - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        pointTags
        numPointsU (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        degreeU (1,1) {mustBeInteger} = 3
        degreeV (1,1) {mustBeInteger} = 3
        weights = []
        knotsU = []
        knotsV = []
        multiplicitiesU = int32([])
        multiplicitiesV = int32([])
        wireTags = int32([])
        wire3D (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelOccAddBSplineSurface', pointTags, numPointsU, tag, degreeU, degreeV, weights, knotsU, knotsV, multiplicitiesU, multiplicitiesV, wireTags, wire3D);
end
