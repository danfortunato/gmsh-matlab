function [x, y, z] = getCenterOfMass(dim, tag)
%GETCENTEROFMASS  gmsh.model.occ.getCenterOfMass
%   Get the center of mass of the OpenCASCADE entity of dimension `dim' and tag
%   `tag'.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    [x, y, z] = gmsh.internal.api.call('gmshModelOccGetCenterOfMass', dim, tag);
end
