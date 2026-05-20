function ret = addBox(x, y, z, dx, dy, dz, tag)
%ADDBOX  gmsh.model.occ.addBox
%   Add a parallelepipedic box in the OpenCASCADE CAD representation, defined by
%   a point (`x', `y', `z') and the extents along the x-, y- and z-axes. If
%   `tag' is positive, set the tag explicitly; otherwise a new tag is selected
%   automatically. Return the tag of the box.
%
%   Inputs:
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     dx - double scalar
%     dy - double scalar
%     dz - double scalar
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        x (1,1) double
        y (1,1) double
        z (1,1) double
        dx (1,1) double
        dy (1,1) double
        dz (1,1) double
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelOccAddBox', x, y, z, dx, dy, dz, tag);
end
