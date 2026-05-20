function reclassifyNodes()
%RECLASSIFYNODES  gmsh.model.mesh.reclassifyNodes
%   Reclassify all nodes on their associated model entity, based on the
%   elements. Can be used when importing nodes in bulk (e.g. by associating them
%   all to a single volume), to reclassify them correctly on model surfaces,
%   curves, etc. after the elements have been set.

    gmsh.internal.api.call('gmshModelMeshReclassifyNodes');
end
