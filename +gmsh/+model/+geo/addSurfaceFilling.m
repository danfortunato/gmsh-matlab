function ret = addSurfaceFilling(wireTags, tag, sphereCenterTag)
%ADDSURFACEFILLING  gmsh.model.geo.addSurfaceFilling
%   Add a surface in the built-in CAD representation, filling the curve loops in
%   `wireTags' using transfinite interpolation. Currently only a single curve
%   loop is supported; this curve loop should be composed by 3 or 4 curves only.
%   If `tag' is positive, set the tag explicitly; otherwise a new tag is
%   selected automatically. Return the tag of the surface.
%
%   Inputs:
%     wireTags - vector of integers
%     tag - integer scalar (default -1)
%     sphereCenterTag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        wireTags
        tag (1,1) {mustBeInteger} = -1
        sphereCenterTag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddSurfaceFilling', wireTags, tag, sphereCenterTag);
end
