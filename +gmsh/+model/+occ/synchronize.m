function synchronize()
%SYNCHRONIZE  gmsh.model.occ.synchronize
%   Synchronize the OpenCASCADE CAD representation with the current Gmsh model.
%   This can be called at any time, but since it involves a non trivial amount
%   of processing, the number of synchronization points should normally be
%   minimized. Without synchronization the entities in the OpenCASCADE CAD
%   representation are not available to any function outside of the OpenCASCADE
%   CAD kernel functions.

    gmsh.internal.api.call('gmshModelOccSynchronize');
end
