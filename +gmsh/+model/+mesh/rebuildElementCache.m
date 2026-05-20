function rebuildElementCache(onlyIfNecessary)
%REBUILDELEMENTCACHE  gmsh.model.mesh.rebuildElementCache
%   Rebuild the element cache.
%
%   Inputs:
%     onlyIfNecessary - logical scalar (default true)

    arguments
        onlyIfNecessary (1,1) logical = true
    end

    gmsh.internal.api.call('gmshModelMeshRebuildElementCache', onlyIfNecessary);
end
