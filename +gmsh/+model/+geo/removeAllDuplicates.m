function removeAllDuplicates()
%REMOVEALLDUPLICATES  gmsh.model.geo.removeAllDuplicates
%   Remove all duplicate entities in the built-in CAD representation (different
%   entities at the same geometrical location).

    gmsh.internal.api.call('gmshModelGeoRemoveAllDuplicates');
end
