function removeConstraints(dimTags)
%REMOVECONSTRAINTS  gmsh.model.mesh.removeConstraints
%   Remove all meshing constraints from the model entities `dimTags', given as a
%   vector of (dim, tag) pairs. If `dimTags' is empty, remove all constraings.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshRemoveConstraints', dimTags);
end
