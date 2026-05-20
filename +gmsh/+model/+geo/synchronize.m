function synchronize()
%SYNCHRONIZE  gmsh.model.geo.synchronize
%   Synchronize the built-in CAD representation with the current Gmsh model.
%   This can be called at any time, but since it involves a non trivial amount
%   of processing, the number of synchronization points should normally be
%   minimized. Without synchronization the entities in the built-in CAD
%   representation are not available to any function outside of the built-in CAD
%   kernel functions.

    gmsh.internal.api.call('gmshModelGeoSynchronize');
end
