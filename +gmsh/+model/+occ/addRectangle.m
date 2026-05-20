function ret = addRectangle(x, y, z, dx, dy, tag, roundedRadius)
%ADDRECTANGLE  gmsh.model.occ.addRectangle
%   Add a rectangle in the OpenCASCADE CAD representation, with lower left
%   corner at (`x', `y', `z') and upper right corner at (`x' + `dx', `y' + `dy',
%   `z'). If `tag' is positive, set the tag explicitly; otherwise a new tag is
%   selected automatically. Round the corners if `roundedRadius' is nonzero.
%   Return the tag of the rectangle.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dx - double scalar
%     dy - double scalar
%     tag - integer scalar (default -1)
%     roundedRadius - double scalar (default 0.)
%
%   Outputs:
%     ret - integer scalar

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        dx (1,1) double
        dy (1,1) double
        tag (1,1) {mustBeInteger} = -1
        roundedRadius (1,1) double = 0.
    end

    ret = gmsh.internal.api.call('gmshModelOccAddRectangle', x, y, z, dx, dy, tag, roundedRadius);
end
