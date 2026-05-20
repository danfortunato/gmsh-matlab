function tags = list()
%LIST  gmsh.model.mesh.field.list
%   Get the list of all fields.
%
%   Outputs:
%     tags - row vector of int32

    tags = gmsh.internal.api.call('gmshModelMeshFieldList');
end
