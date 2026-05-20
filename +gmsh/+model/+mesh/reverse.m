function reverse(dimTags)
%REVERSE  gmsh.model.mesh.reverse
%   Reverse the orientation of the elements in the entities `dimTags', given as
%   a vector of (dim, tag) pairs. If `dimTags' is empty, reverse the orientation
%   of the elements in the whole mesh.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshReverse', dimTags);
end
