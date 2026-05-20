function setSize(dimTags, sz)
%SETSIZE  gmsh.model.occ.mesh.setSize
%   Set a mesh size constraint on the entities `dimTags' (given as a vector of
%   (dim, tag) pairs) in the OpenCASCADE CAD representation. Currently only
%   entities of dimension 0 (points) are handled.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     sz - double scalar

    arguments
        dimTags
        sz (1,1) double
    end

    gmsh.internal.api.call('gmshModelOccMeshSetSize', dimTags, sz);
end
