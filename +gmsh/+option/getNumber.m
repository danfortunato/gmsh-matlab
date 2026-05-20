function value = getNumber(name)
%GETNUMBER  gmsh.option.getNumber
%   Get the `value' of a numerical option. `name' is of the form
%   "Category.Option" or "Category[num].Option". Available categories and
%   options are listed in the "Gmsh options" chapter of the Gmsh reference
%   manual (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-options).
%
%   Inputs:
%     name - string
%
%   Outputs:
%     value - double scalar

    arguments
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshOptionGetNumber', name);
end
