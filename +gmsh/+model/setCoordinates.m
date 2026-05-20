function setCoordinates(tag, x, y, z)
%SETCOORDINATES  gmsh.model.setCoordinates
%   Set the `x', `y', `z' coordinates of a geometrical point.
%
%   Inputs:
%     tag - integer scalar
%     x - double scalar
%     y - double scalar
%     z - double scalar

    arguments
        tag (1,1) {mustBeInteger}
        x (1,1) double
        y (1,1) double
        z (1,1) double
    end

    gmsh.internal.api.call('gmshModelSetCoordinates', tag, x, y, z);
end
