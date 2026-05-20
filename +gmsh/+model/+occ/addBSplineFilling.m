function ret = addBSplineFilling(wireTag, tag, kind)
%ADDBSPLINEFILLING  gmsh.model.occ.addBSplineFilling
%   Add a BSpline surface in the OpenCASCADE CAD representation, filling the
%   curve loop `wireTag'. The curve loop should be made of 2, 3 or 4 curves. The
%   optional `type' argument specifies the type of filling: "Stretch" creates
%   the flattest patch, "Curved" (the default) creates the most rounded patch,
%   and "Coons" creates a rounded patch with less depth than "Curved". If `tag'
%   is positive, set the tag explicitly; otherwise a new tag is selected
%   automatically. Return the tag of the surface.
%
%   Inputs:
%     wireTag - integer scalar
%     tag - integer scalar (default -1)
%     kind - string (default '')
%
%   Outputs:
%     ret - integer scalar

    arguments
        wireTag (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        kind (1,:) char = ''
    end

    ret = gmsh.internal.api.call('gmshModelOccAddBSplineFilling', wireTag, tag, kind);
end
