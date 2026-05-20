function outDimTags = addThruSections(wireTags, tag, makeSolid, makeRuled, maxDegree, continuity, parametrization, smoothing)
%ADDTHRUSECTIONS  gmsh.model.occ.addThruSections
%   Add a volume (if the optional argument `makeSolid' is set) or surfaces in
%   the OpenCASCADE CAD representation, defined through the open or closed wires
%   `wireTags'. If `tag' is positive, set the tag explicitly; otherwise a new
%   tag is selected automatically. The new entities are returned in `outDimTags'
%   as a vector of (dim, tag) pairs. If the optional argument `makeRuled' is
%   set, the surfaces created on the boundary are forced to be ruled surfaces.
%   If `maxDegree' is positive, set the maximal degree of resulting surface. The
%   optional argument `continuity' allows to specify the continuity of the
%   resulting shape ("C0", "G1", "C1", "G2", "C2", "C3", "CN"). The optional
%   argument `parametrization' sets the parametrization type ("ChordLength",
%   "Centripetal", "IsoParametric"). The optional argument `smoothing'
%   determines if smoothing is applied.
%
%   Inputs:
%     wireTags - vector of integers
%     tag - integer scalar (default -1)
%     makeSolid - logical scalar (default true)
%     makeRuled - logical scalar (default false)
%     maxDegree - integer scalar (default -1)
%     continuity - string (default '')
%     parametrization - string (default '')
%     smoothing - logical scalar (default false)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        wireTags
        tag (1,1) {mustBeInteger} = -1
        makeSolid (1,1) logical = true
        makeRuled (1,1) logical = false
        maxDegree (1,1) {mustBeInteger} = -1
        continuity (1,:) char = ''
        parametrization (1,:) char = ''
        smoothing (1,1) logical = false
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccAddThruSections', wireTags, tag, makeSolid, makeRuled, maxDegree, continuity, parametrization, smoothing);
end
