function createFaces(dimTags)
%CREATEFACES  gmsh.model.mesh.createFaces
%   Create unique mesh faces for the entities `dimTags', given as a vector of
%   (dim, tag) pairs.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshCreateFaces', dimTags);
end
