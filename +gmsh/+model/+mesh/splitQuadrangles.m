function splitQuadrangles(quality, tag)
%SPLITQUADRANGLES  gmsh.model.mesh.splitQuadrangles
%   Split (into two triangles) all quadrangles in surface `tag' whose quality is
%   lower than `quality'. If `tag' < 0, split quadrangles in all surfaces.
%
%   Inputs:
%     quality - double scalar (default 1.)
%     tag - integer scalar (default -1)

    arguments
        quality (1,1) double = 1.
        tag (1,1) {mustBeInteger} = -1
    end

    gmsh.internal.api.call('gmshModelMeshSplitQuadrangles', quality, tag);
end
