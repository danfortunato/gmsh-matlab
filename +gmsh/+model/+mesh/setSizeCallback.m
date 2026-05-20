function setSizeCallback(callback)
%SETSIZECALLBACK  gmsh.model.mesh.setSizeCallback
%   Set a mesh size callback for the current model. The callback function should
%   take six arguments as input (`dim', `tag', `x', `y', `z' and `lc'). The
%   first two integer arguments correspond to the dimension `dim' and tag `tag'
%   of the entity being meshed. The next four double precision arguments
%   correspond to the coordinates `x', `y' and `z' around which to prescribe the
%   mesh size and to the mesh size `lc' that would be prescribed if the callback
%   had not been called. The callback function should return a double precision
%   number specifying the desired mesh size; returning `lc' is equivalent to a
%   no-op.
%
%   Inputs:
%     callback - function handle

    arguments
        callback (1,1) function_handle
    end

    gmsh.internal.api.call('gmshModelMeshSetSizeCallback', callback);
end
