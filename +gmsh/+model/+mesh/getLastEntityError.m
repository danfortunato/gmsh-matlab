function dimTags = getLastEntityError()
%GETLASTENTITYERROR  gmsh.model.mesh.getLastEntityError
%   Get the last entities `dimTags' (as a vector of (dim, tag) pairs) where a
%   meshing error occurred. Currently only populated by the new 3D meshing
%   algorithms.
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs

    dimTags = gmsh.internal.api.call('gmshModelMeshGetLastEntityError');
end
