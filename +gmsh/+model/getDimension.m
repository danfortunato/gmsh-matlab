function ret = getDimension()
%GETDIMENSION  gmsh.model.getDimension
%   Return the geometrical dimension of the current model.
%
%   Outputs:
%     ret - integer scalar

    ret = gmsh.internal.api.call('gmshModelGetDimension');
end
