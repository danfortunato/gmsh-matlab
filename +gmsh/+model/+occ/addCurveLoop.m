function ret = addCurveLoop(curveTags, tag)
%ADDCURVELOOP  gmsh.model.occ.addCurveLoop
%   Add a curve loop (a closed wire) in the OpenCASCADE CAD representation,
%   formed by the curves `curveTags'. `curveTags' should contain tags of curves
%   forming a closed loop. Negative tags can be specified for compatibility with
%   the built-in kernel, but are simply ignored: the wire is oriented according
%   to the orientation of its first curve. Note that an OpenCASCADE curve loop
%   can be made of curves that share geometrically identical (but topologically
%   different) points. If `tag' is positive, set the tag explicitly; otherwise a
%   new tag is selected automatically. Return the tag of the curve loop.
%
%   Inputs:
%     curveTags - vector of integers
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        curveTags
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelOccAddCurveLoop', curveTags, tag);
end
