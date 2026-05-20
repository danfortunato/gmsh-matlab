function affineTransform(affineTransform, dimTags)
%AFFINETRANSFORM  gmsh.model.mesh.affineTransform
%   Apply the affine transformation `affineTransform' (16 entries of a 4x4
%   matrix, by row; only the 12 first can be provided for convenience) to the
%   coordinates of the nodes classified on the entities `dimTags', given as a
%   vector of (dim, tag) pairs. If `dimTags' is empty, transform all the nodes
%   in the mesh.
%
%   Inputs:
%     affineTransform - vector of doubles
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))

    arguments
        affineTransform
        dimTags = zeros(0,2)
    end

    gmsh.internal.api.call('gmshModelMeshAffineTransform', affineTransform, dimTags);
end
