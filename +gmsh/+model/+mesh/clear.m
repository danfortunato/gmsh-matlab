function clear(dimTags)
%CLEAR  gmsh.model.mesh.clear
%   Clear the mesh, i.e. delete all the nodes and elements, for the entities
%   `dimTags', given as a vector of (dim, tag) pairs. If `dimTags' is empty,
%   clear the whole mesh. Note that the mesh of an entity can only be cleared if
%   this entity is not on the boundary of another entity with a non-empty mesh.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshClear', dimTags);
end
