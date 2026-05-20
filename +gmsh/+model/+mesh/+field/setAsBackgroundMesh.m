function setAsBackgroundMesh(tag)
%SETASBACKGROUNDMESH  gmsh.model.mesh.field.setAsBackgroundMesh
%   Set the field `tag' as the background mesh size field.
%
%   Inputs:
%     tag - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshFieldSetAsBackgroundMesh', tag);
end
