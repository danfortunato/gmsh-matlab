function mat = getMatrixOfInertia(dim, tag)
%GETMATRIXOFINERTIA  gmsh.model.occ.getMatrixOfInertia
%   Get the matrix of inertia (by row) of the OpenCASCADE entity of dimension
%   `dim' and tag `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     mat - row vector of doubles

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    mat = gmsh.internal.api.call('gmshModelOccGetMatrixOfInertia', dim, tag);
end
