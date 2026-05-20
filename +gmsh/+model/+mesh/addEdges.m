function addEdges(edgeTags, edgeNodes)
%ADDEDGES  gmsh.model.mesh.addEdges
%   Add mesh edges defined by their global unique identifiers `edgeTags' and
%   their nodes `edgeNodes'.
%
%   Inputs:
%     edgeTags - vector of size_t
%     edgeNodes - vector of size_t

    arguments
        edgeTags
        edgeNodes
    end

    gmsh.internal.api.call('gmshModelMeshAddEdges', edgeTags, edgeNodes);
end
