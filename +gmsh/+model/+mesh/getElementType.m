function ret = getElementType(familyName, order, serendip)
%GETELEMENTTYPE  gmsh.model.mesh.getElementType
%   Return an element type given its family name `familyName' ("Point", "Line",
%   "Triangle", "Quadrangle", "Tetrahedron", "Pyramid", "Prism", "Hexahedron")
%   and polynomial order `order'. If `serendip' is true, return the
%   corresponding serendip element type (element without interior nodes).
%
%   Inputs:
%     familyName - string
%     order - integer scalar
%     serendip - logical scalar (default false)
%
%   Outputs:
%     ret - integer scalar

    arguments
        familyName (1,:) char
        order (1,1) {mustBeInteger}
        serendip (1,1) logical = false
    end

    ret = gmsh.internal.api.call('gmshModelMeshGetElementType', familyName, order, serendip);
end
