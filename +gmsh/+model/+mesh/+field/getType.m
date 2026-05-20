function fileType = getType(tag)
%GETTYPE  gmsh.model.mesh.field.getType
%   Get the type `fieldType' of the field with tag `tag'.
%
%   Inputs:
%     tag - integer scalar
%
%   Outputs:
%     fileType - string

    arguments
        tag (1,1) {mustBeInteger}
    end

    fileType = gmsh.internal.api.call('gmshModelMeshFieldGetType', tag);
end
