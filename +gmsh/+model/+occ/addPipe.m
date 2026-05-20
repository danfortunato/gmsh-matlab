function outDimTags = addPipe(dimTags, wireTag, trihedron)
%ADDPIPE  gmsh.model.occ.addPipe
%   Add a pipe in the OpenCASCADE CAD representation, by extruding the entities
%   `dimTags' (given as a vector of (dim, tag) pairs) along the wire `wireTag'.
%   The type of sweep can be specified with `trihedron' (possible values:
%   "DiscreteTrihedron", "CorrectedFrenet", "Fixed", "Frenet", "ConstantNormal",
%   "Darboux", "GuideAC", "GuidePlan", "GuideACWithContact",
%   "GuidePlanWithContact"). If `trihedron' is not provided, "DiscreteTrihedron"
%   is assumed. Return the pipe in `outDimTags'.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     wireTag - integer scalar
%     trihedron - string (default '')
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags
        wireTag (1,1) {mustBeInteger}
        trihedron (1,:) char = ''
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccAddPipe', dimTags, wireTag, trihedron);
end
