function tags = addCurveLoops(curveTags)
%ADDCURVELOOPS  gmsh.model.geo.addCurveLoops
%   Add curve loops in the built-in CAD representation based on the curves
%   `curveTags'. Return the `tags' of found curve loops, if any.
%
%   Inputs:
%     curveTags - vector of integers
%
%   Outputs:
%     tags - row vector of int32

    arguments
        curveTags
    end

    tags = gmsh.internal.api.call('gmshModelGeoAddCurveLoops', curveTags);
end
