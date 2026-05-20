function [distance, x1, y1, z1, x2, y2, z2] = getDistance(dim1, tag1, dim2, tag2)
%GETDISTANCE  gmsh.model.occ.getDistance
%   Find the minimal distance between shape with `dim1' and `tag1' and shape
%   with `dim2' and `tag2' and the according coordinates. Return the distance in
%   `distance' and the coordinates of the points as `x1', `y1', `z1' and `x2',
%   `y2', `z2'. A negative `distance' indicates failure.
%
%   Inputs:
%     dim1 - integer scalar
%     tag1 - integer scalar
%     dim2 - integer scalar
%     tag2 - integer scalar
%
%   Outputs:
%     distance - double scalar
%     x1 - double scalar
%     y1 - double scalar
%     z1 - double scalar
%     x2 - double scalar
%     y2 - double scalar
%     z2 - double scalar

    arguments
        dim1 (1,1) {mustBeInteger}
        tag1 (1,1) {mustBeInteger}
        dim2 (1,1) {mustBeInteger}
        tag2 (1,1) {mustBeInteger}
    end

    [distance, x1, y1, z1, x2, y2, z2] = gmsh.internal.api.call('gmshModelOccGetDistance', dim1, tag1, dim2, tag2);
end
