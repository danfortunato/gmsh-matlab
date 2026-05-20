function ret = addPlaneSurface(wireTags, tag)
%ADDPLANESURFACE  gmsh.model.occ.addPlaneSurface
%   Add a plane surface in the OpenCASCADE CAD representation, defined by one or
%   more curve loops (or closed wires) `wireTags'. The first curve loop defines
%   the exterior contour; additional curve loop define holes. If `tag' is
%   positive, set the tag explicitly; otherwise a new tag is selected
%   automatically. Return the tag of the surface.
%
%   Inputs:
%     wireTags - vector of integers
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        wireTags
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelOccAddPlaneSurface', wireTags, tag);
end
