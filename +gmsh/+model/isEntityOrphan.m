function ret = isEntityOrphan(dim, tag)
%ISENTITYORPHAN  gmsh.model.isEntityOrphan
%   Return whether the model entity of dimension `dim' and tag `tag' is an
%   orphan, i.e. is not connected to any entity of the highest dimension in the
%   model.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     ret - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    ret = gmsh.internal.api.call('gmshModelIsEntityOrphan', dim, tag);
end
