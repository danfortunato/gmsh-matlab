function ret = addWire(curveTags, tag, checkClosed)
%ADDWIRE  gmsh.model.occ.addWire
%   Add a wire (open or closed) in the OpenCASCADE CAD representation, formed by
%   the curves `curveTags'. Note that an OpenCASCADE wire can be made of curves
%   that share geometrically identical (but topologically different) points. If
%   `tag' is positive, set the tag explicitly; otherwise a new tag is selected
%   automatically. Return the tag of the wire.
%
%   Inputs:
%     curveTags - vector of integers
%     tag - integer scalar (default -1)
%     checkClosed - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        curveTags
        tag (1,1) {mustBeInteger} = -1
        checkClosed (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelOccAddWire', curveTags, tag, checkClosed);
end
