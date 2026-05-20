function removeAllDuplicates()
%REMOVEALLDUPLICATES  gmsh.model.occ.removeAllDuplicates
%   Remove all duplicate entities in the OpenCASCADE CAD representation
%   (different entities at the same geometrical location) after intersecting
%   (using boolean fragments) all highest dimensional entities.

    gmsh.internal.api.call('gmshModelOccRemoveAllDuplicates');
end
