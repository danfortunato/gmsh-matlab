function embed(dim, tags, inDim, inTag)
%EMBED  gmsh.model.mesh.embed
%   Embed the model entities of dimension `dim' and tags `tags' in the (`inDim',
%   `inTag') model entity. The dimension `dim' can 0, 1 or 2 and must be
%   strictly smaller than `inDim', which must be either 2 or 3. The embedded
%   entities should not intersect each other or be part of the boundary of the
%   entity `inTag', whose mesh will conform to the mesh of the embedded
%   entities. With the OpenCASCADE kernel, if the `fragment' operation is
%   applied to entities of different dimensions, the lower dimensional entities
%   will be automatically embedded in the higher dimensional entities if they
%   are not on their boundary.
%
%   Inputs:
%     dim - integer scalar
%     tags - vector of integers
%     inDim - integer scalar
%     inTag - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tags
        inDim (1,1) {mustBeInteger}
        inTag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshEmbed', dim, tags, inDim, inTag);
end
