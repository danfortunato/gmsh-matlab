function dimTags = computeHomology()
%COMPUTEHOMOLOGY  gmsh.model.mesh.computeHomology
%   Perform the (co)homology computations requested by addHomologyRequest(). The
%   newly created physical groups are returned in `dimTags' as a vector of (dim,
%   tag) pairs.
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs

    dimTags = gmsh.internal.api.call('gmshModelMeshComputeHomology');
end
