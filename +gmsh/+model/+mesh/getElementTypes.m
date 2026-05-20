function elementTypes = getElementTypes(dim, tag)
%GETELEMENTTYPES  gmsh.model.mesh.getElementTypes
%   Get the types of elements in the entity of dimension `dim' and tag `tag'. If
%   `tag' < 0, get the types for all entities of dimension `dim'. If `dim' and
%   `tag' are negative, get all the types in the mesh.
%
%   Inputs:
%     dim - integer scalar (default -1)
%     tag - integer scalar (default -1)
%
%   Outputs:
%     elementTypes - row vector of int32

    arguments
        dim (1,1) {mustBeInteger} = -1
        tag (1,1) {mustBeInteger} = -1
    end

    elementTypes = gmsh.internal.api.call('gmshModelMeshGetElementTypes', dim, tag);
end
