function clearHomologyRequests()
%CLEARHOMOLOGYREQUESTS  gmsh.model.mesh.clearHomologyRequests
%   Clear all (co)homology computation requests.

    gmsh.internal.api.call('gmshModelMeshClearHomologyRequests');
end
