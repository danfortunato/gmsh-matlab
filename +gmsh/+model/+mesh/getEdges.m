function [edgeTags, edgeOrientations] = getEdges(nodeTags)
%GETEDGES  gmsh.model.mesh.getEdges
%   Get the global unique mesh edge identifiers `edgeTags' and orientations
%   `edgeOrientation' for an input list of node tag pairs defining these edges,
%   concatenated in the vector `nodeTags'. Mesh edges are created e.g. by
%   `createEdges()', `getKeys()' or `addEdges()'. The reference positive
%   orientation is n1 < n2, where n1 and n2 are the tags of the two edge nodes,
%   which corresponds to the local orientation of edge-based basis functions as
%   well.
%
%   Inputs:
%     nodeTags - vector of size_t
%
%   Outputs:
%     edgeTags - row vector of uint64
%     edgeOrientations - row vector of int32

    arguments
        nodeTags
    end

    [edgeTags, edgeOrientations] = gmsh.internal.api.call('gmshModelMeshGetEdges', nodeTags);
end
