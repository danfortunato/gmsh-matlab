function createGeometry(dimTags)
%CREATEGEOMETRY  gmsh.model.mesh.createGeometry
%   Create a geometry for the discrete entities `dimTags' (given as a vector of
%   (dim, tag) pairs) represented solely by a mesh (without an underlying CAD
%   description), i.e. create a parametrization for discrete curves and
%   surfaces, assuming that each can be parametrized with a single map. If
%   `dimTags' is empty, create a geometry for all the discrete entities.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshCreateGeometry', dimTags);
end
