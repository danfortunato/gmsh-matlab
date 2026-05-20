function setAsBoundaryLayer(tag)
%SETASBOUNDARYLAYER  gmsh.model.mesh.field.setAsBoundaryLayer
%   Set the field `tag' as a boundary layer size field.
%
%   Inputs:
%     tag - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshFieldSetAsBoundaryLayer', tag);
end
