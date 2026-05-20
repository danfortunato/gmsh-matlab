function names = getAttributeNames()
%GETATTRIBUTENAMES  gmsh.model.getAttributeNames
%   Get the names of any optional attributes stored in the model.
%
%   Outputs:
%     names - cell of strings

    names = gmsh.internal.api.call('gmshModelGetAttributeNames');
end
