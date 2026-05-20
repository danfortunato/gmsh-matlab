function outDimTags = healShapes(dimTags, tolerance, fixDegenerated, fixSmallEdges, fixSmallFaces, sewFaces, makeSolids)
%HEALSHAPES  gmsh.model.occ.healShapes
%   Apply various healing procedures to the entities `dimTags' (given as a
%   vector of (dim, tag) pairs), or to all the entities in the model if
%   `dimTags' is empty, in the OpenCASCADE CAD representation. Return the healed
%   entities in `outDimTags'.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))
%     tolerance - double scalar (default 1e-8)
%     fixDegenerated - logical scalar (default true)
%     fixSmallEdges - logical scalar (default true)
%     fixSmallFaces - logical scalar (default true)
%     sewFaces - logical scalar (default true)
%     makeSolids - logical scalar (default true)
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        dimTags = zeros(0,2)
        tolerance (1,1) double = 1e-8
        fixDegenerated (1,1) logical = true
        fixSmallEdges (1,1) logical = true
        fixSmallFaces (1,1) logical = true
        sewFaces (1,1) logical = true
        makeSolids (1,1) logical = true
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccHealShapes', dimTags, tolerance, fixDegenerated, fixSmallEdges, fixSmallFaces, sewFaces, makeSolids);
end
