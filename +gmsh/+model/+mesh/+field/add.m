function ret = add(fieldType, tag)
%ADD  gmsh.model.mesh.field.add
%   Add a new mesh size field of type `fieldType'. If `tag' is positive, assign
%   the tag explicitly; otherwise a new tag is assigned automatically. Return
%   the field tag. Available field types are listed in the "Gmsh mesh size
%   fields" chapter of the Gmsh reference manual
%   (https://gmsh.info/doc/texinfo/gmsh.html#Gmsh-mesh-size-fields).
%
%   Inputs:
%     fieldType - string
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        fieldType (1,:) char
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelMeshFieldAdd', fieldType, tag);
end
