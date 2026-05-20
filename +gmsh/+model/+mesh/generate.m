function generate(dim)
%GENERATE  gmsh.model.mesh.generate
%   Generate a mesh of the current model, up to dimension `dim' (0, 1, 2 or 3).
%
%   Inputs:
%     dim - integer scalar (default 3)

    arguments
        dim (1,1) {mustBeInteger} = 3
    end

    gmsh.internal.api.call('gmshModelMeshGenerate', dim);
end
