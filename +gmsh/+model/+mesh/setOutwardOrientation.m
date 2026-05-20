function setOutwardOrientation(tag)
%SETOUTWARDORIENTATION  gmsh.model.mesh.setOutwardOrientation
%   Set meshing constraints on the bounding surfaces of the volume of tag `tag'
%   so that all surfaces are oriented with outward pointing normals; and if a
%   mesh already exists, reorient it. Currently only available with the
%   OpenCASCADE kernel, as it relies on the STL triangulation.
%
%   Inputs:
%     tag - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshModelMeshSetOutwardOrientation', tag);
end
