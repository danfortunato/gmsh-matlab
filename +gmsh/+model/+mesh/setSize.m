function setSize(dimTags, sz)
%SETSIZE  gmsh.model.mesh.setSize
%   Set a mesh size constraint on the model entities `dimTags', given as a
%   vector of (dim, tag) pairs. Currently only entities of dimension 0 (points)
%   are handled.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     sz - double scalar

    arguments
        dimTags
        sz (1,1) double
    end

    gmsh.internal.api.call('gmshModelMeshSetSize', dimTags, sz);
end
