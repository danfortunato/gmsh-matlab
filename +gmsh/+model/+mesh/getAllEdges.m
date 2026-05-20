function [edgeTags, edgeNodes] = getAllEdges()
%GETALLEDGES  gmsh.model.mesh.getAllEdges
%   Get the global unique identifiers `edgeTags' and the nodes `edgeNodes' of
%   the edges in the mesh. Mesh edges are created e.g. by `createEdges()',
%   `getKeys()' or addEdges().
%
%   Outputs:
%     edgeTags - row vector of uint64
%     edgeNodes - row vector of uint64

    [edgeTags, edgeNodes] = gmsh.internal.api.call('gmshModelMeshGetAllEdges');
end
