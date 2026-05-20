function value = getString(name)
%GETSTRING  gmsh.option.getString
%   Get the `value' of a string option. `name' is of the form "Category.Option"
%   or "Category[num].Option". Available categories and options are listed in
%   the "Gmsh options" chapter of the Gmsh reference manual
%   (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-options).
%
%   Inputs:
%     name - string
%
%   Outputs:
%     value - string

    arguments
        name (1,:) char
    end

    value = gmsh.internal.api.call('gmshOptionGetString', name);
end
