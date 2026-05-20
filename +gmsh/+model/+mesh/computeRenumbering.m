function [oldTags, newTags] = computeRenumbering(method, elementTags)
%COMPUTERENUMBERING  gmsh.model.mesh.computeRenumbering
%   Compute a renumbering vector `newTags' corresponding to the input tags
%   `oldTags' for a given list of element tags `elementTags'. If `elementTags'
%   is empty, compute the renumbering on the full mesh. If `method' is equal to
%   "RCMK", compute a node renumering with Reverse Cuthill McKee. If `method' is
%   equal to "Hilbert", compute a node renumering along a Hilbert curve. If
%   `method' is equal to "Metis", compute a node renumering using Metis. Element
%   renumbering is not available yet.
%
%   Inputs:
%     method - string (default "RCMK")
%     elementTags - vector of size_t (default uint64([]))
%
%   Outputs:
%     oldTags - row vector of uint64
%     newTags - row vector of uint64

    arguments
        method (1,:) char = "RCMK"
        elementTags = uint64([])
    end

    [oldTags, newTags] = gmsh.internal.api.call('gmshModelMeshComputeRenumbering', method, elementTags);
end
