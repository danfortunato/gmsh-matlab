function ret = addCurveLoop(curveTags, tag, reorient)
%ADDCURVELOOP  gmsh.model.geo.addCurveLoop
%   Add a curve loop (a closed wire) in the built-in CAD representation, formed
%   by the curves `curveTags'. `curveTags' should contain (signed) tags of model
%   entities of dimension 1 forming a closed loop: a negative tag signifies that
%   the underlying curve is considered with reversed orientation. If `tag' is
%   positive, set the tag explicitly; otherwise a new tag is selected
%   automatically. If `reorient' is set, automatically reorient the curves if
%   necessary. Return the tag of the curve loop.
%
%   Inputs:
%     curveTags - vector of integers
%     tag - integer scalar (default -1)
%     reorient - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        curveTags
        tag (1,1) {mustBeInteger} = -1
        reorient (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelGeoAddCurveLoop', curveTags, tag, reorient);
end
