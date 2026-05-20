function names = list()
%LIST  gmsh.model.list
%   List the names of all models.
%
%   Outputs:
%     names - cell of strings

    names = gmsh.internal.api.call('gmshModelList');
end
