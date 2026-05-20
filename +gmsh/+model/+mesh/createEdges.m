function createEdges(dimTags)
%CREATEEDGES  gmsh.model.mesh.createEdges
%   Create unique mesh edges for the entities `dimTags', given as a vector of
%   (dim, tag) pairs.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshCreateEdges', dimTags);
end
