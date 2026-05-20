function [jacobians, determinants, coord] = getJacobian(elementTag, localCoord)
%GETJACOBIAN  gmsh.model.mesh.getJacobian
%   Get the Jacobian for a single element `elementTag', at the G evaluation
%   points `localCoord' given as concatenated u, v, w coordinates in the
%   reference element [g1u, g1v, g1w, ..., gGu, gGv, gGw]. `jacobians' contains
%   the 9 entries of the 3x3 Jacobian matrix at each evaluation point. The
%   matrix is returned by column: [e1g1Jxu, e1g1Jyu, e1g1Jzu, e1g1Jxv, ...,
%   e1g1Jzw, e1g2Jxu, ..., e1gGJzw, e2g1Jxu, ...], with Jxu = dx/du, Jyu =
%   dy/du, etc. `determinants' contains the determinant of the Jacobian matrix
%   at each evaluation point. `coord' contains the x, y, z coordinates of the
%   evaluation points. This function relies on an internal cache (a vector in
%   case of dense element numbering, a map otherwise); for large meshes
%   accessing Jacobians in bulk is often preferable.
%
%   Inputs:
%     elementTag - size_t scalar
%     localCoord - vector of doubles
%
%   Outputs:
%     jacobians - row vector of doubles
%     determinants - row vector of doubles
%     coord - row vector of doubles

    arguments
        elementTag (1,1) {mustBeInteger, mustBeNonnegative}
        localCoord
    end

    [jacobians, determinants, coord] = gmsh.internal.api.call('gmshModelMeshGetJacobian', elementTag, localCoord);
end
