function viewTags = computeCrossField()
%COMPUTECROSSFIELD  gmsh.model.mesh.computeCrossField
%   Compute a cross field for the current mesh. The function creates 3 views:
%   the H function, the Theta function and cross directions. Return the tags of
%   the views.
%
%   Outputs:
%     viewTags - row vector of int32

    viewTags = gmsh.internal.api.call('gmshModelMeshComputeCrossField');
end
