function optimize(method, force, niter, dimTags)
%OPTIMIZE  gmsh.model.mesh.optimize
%   Optimize the mesh of the current model using `method' (empty for default
%   tetrahedral mesh optimizer, "Netgen" for Netgen optimizer, "HighOrder" for
%   direct high-order mesh optimizer, "HighOrderElastic" for high-order elastic
%   smoother, "HighOrderFastCurving" for fast curving algorithm, "Laplace2D" for
%   Laplace smoothing, "Relocate2D" and "Relocate3D" for node relocation,
%   "QuadQuasiStructured" for quad mesh optimization, "UntangleMeshGeometry" for
%   untangling). If `force' is set apply the optimization also to discrete
%   entities. If `dimTags' (given as a vector of (dim, tag) pairs) is given,
%   only apply the optimizer to the given entities.
%
%   Inputs:
%     method - string (default '')
%     force - logical scalar (default false)
%     niter - integer scalar (default 1)
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        method (1,:) char = ''
        force (1,1) logical = false
        niter (1,1) {mustBeInteger} = 1
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshOptimize', method, force, niter, dimTags);
end
