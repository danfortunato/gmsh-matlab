function setString(name, value)
%SETSTRING  gmsh.option.setString
%   Set a string option to `value'. `name' is of the form "Category.Option" or
%   "Category[num].Option". Available categories and options are listed in the
%   "Gmsh options" chapter of the Gmsh reference manual
%   (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-options).
%
%   Inputs:
%     name - string
%     value - string

    arguments
        name (1,:) char
        value (1,:) char
    end

    gmsh.internal.api.call('gmshOptionSetString', name, value);
end
