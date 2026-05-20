function setPeriodic(dim, tags, tagsMaster, affineTransform)
%SETPERIODIC  gmsh.model.mesh.setPeriodic
%   Set the meshes of the entities of dimension `dim' and tag `tags' as periodic
%   copies of the meshes of entities `tagsMaster', using the affine
%   transformation specified in `affineTransformation' (16 entries of a 4x4
%   matrix, by row). If used after meshing, generate the periodic node
%   correspondence information assuming the meshes of entities `tags'
%   effectively match the meshes of entities `tagsMaster' (useful for structured
%   and extruded meshes). Currently only available for @code{dim} == 1 and
%   @code{dim} == 2.
%
%   Inputs:
%     dim - integer scalar
%     tags - vector of integers
%     tagsMaster - vector of integers
%     affineTransform - vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tags
        tagsMaster
        affineTransform
    end

    gmsh.internal.api.call('gmshModelMeshSetPeriodic', dim, tags, tagsMaster, affineTransform);
end
