function setOrder(order)
%SETORDER  gmsh.model.mesh.setOrder
%   Change the order of the elements in the mesh of the current model to
%   `order'.
%
%   Inputs:
%     order - integer scalar

    arguments
        order (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshSetOrder', order);
end
