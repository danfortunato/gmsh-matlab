function dimTags = getEntitiesForPhysicalName(name)
%GETENTITIESFORPHYSICALNAME  gmsh.model.getEntitiesForPhysicalName
%   Get the model entities (as a vector (dim, tag) pairs) making up the physical
%   group with name `name'.
%
%   Inputs:
%     name - string
%
%   Outputs:
%     dimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        name (1,:) char
    end

    dimTags = gmsh.internal.api.call('gmshModelGetEntitiesForPhysicalName', name);
end
