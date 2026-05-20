function ret = chamfer2D(edgeTag1, edgeTag2, distance1, distance2, tag)
%CHAMFER2D  gmsh.model.occ.chamfer2D
%   Create a chamfer edge between edges `edgeTag1' and `edgeTag2' with distance1
%   `distance1' and distance2 `distance2'. The modifed edges keep their tag. If
%   `tag' is positive, set the tag explicitly; otherwise a new tag is selected
%   automatically.
%
%   Inputs:
%     edgeTag1 - integer scalar
%     edgeTag2 - integer scalar
%     distance1 - double scalar
%     distance2 - double scalar
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        edgeTag1 (1,1) {mustBeInteger}
        edgeTag2 (1,1) {mustBeInteger}
        distance1 (1,1) double
        distance2 (1,1) double
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelOccChamfer2D', edgeTag1, edgeTag2, distance1, distance2, tag);
end
