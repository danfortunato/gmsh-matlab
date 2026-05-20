function sizes = getSizes(dimTags)
%GETSIZES  gmsh.model.mesh.getSizes
%   Get the mesh size constraints (if any) associated with the model entities
%   `dimTags', given as a vector of (dim, tag) pairs. A zero entry in the output
%   `sizes' vector indicates that no size constraint is specified on the
%   corresponding entity.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%
%   Outputs:
%     sizes - row vector of doubles

    arguments
        dimTags
    end

    sizes = gmsh.internal.api.call('gmshModelMeshGetSizes', dimTags);
end
