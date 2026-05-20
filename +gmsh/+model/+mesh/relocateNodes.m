function relocateNodes(dim, tag)
%RELOCATENODES  gmsh.model.mesh.relocateNodes
%   Relocate the nodes classified on the entity of dimension `dim' and tag `tag'
%   using their parametric coordinates. If `tag' < 0, relocate the nodes for all
%   entities of dimension `dim'. If `dim' and `tag' are negative, relocate all
%   the nodes in the mesh.
%
%   Inputs:
%     dim - integer scalar (default -1)
%     tag - integer scalar (default -1)

    arguments
        dim (1,1) {mustBeInteger} = -1
        tag (1,1) {mustBeInteger} = -1
    end

    gmsh.internal.api.call('gmshModelMeshRelocateNodes', dim, tag);
end
