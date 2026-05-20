function affineTransform(dimTags, affineTransform)
%AFFINETRANSFORM  gmsh.model.occ.affineTransform
%   Apply a general affine transformation matrix `affineTransform' (16 entries
%   of a 4x4 matrix, by row; only the 12 first can be provided for convenience)
%   to the entities `dimTags' (given as a vector of (dim, tag) pairs) in the
%   OpenCASCADE CAD representation.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag)
%     affineTransform - vector of doubles

    arguments
        dimTags
        affineTransform
    end

    gmsh.internal.api.call('gmshModelOccAffineTransform', dimTags, affineTransform);
end
