function setNumber(name, value)
%SETNUMBER  gmsh.option.setNumber
%   Set a numerical option to `value'. `name' is of the form "Category.Option"
%   or "Category[num].Option". Available categories and options are listed in
%   the "Gmsh options" chapter of the Gmsh reference manual
%   (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-options).
%
%   Inputs:
%     name - string
%     value - double scalar

    arguments
        name (1,:) char
        value (1,1) double
    end

    gmsh.internal.api.call('gmshOptionSetNumber', name, value);
end
