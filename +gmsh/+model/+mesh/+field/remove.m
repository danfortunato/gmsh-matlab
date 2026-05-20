function remove(tag)
%REMOVE  gmsh.model.mesh.field.remove
%   Remove the field with tag `tag'.
%
%   Inputs:
%     tag - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshFieldRemove', tag);
end
