function setTransfiniteAutomatic(dimTags, cornerAngle, recombine)
%SETTRANSFINITEAUTOMATIC  gmsh.model.mesh.setTransfiniteAutomatic
%   Set transfinite meshing constraints on the model entities in `dimTags',
%   given as a vector of (dim, tag) pairs. Transfinite meshing constraints are
%   added to the curves of the quadrangular surfaces and to the faces of 6-sided
%   volumes. Quadragular faces with a corner angle superior to `cornerAngle' (in
%   radians) are ignored. The number of points is automatically determined from
%   the sizing constraints. If `dimTag' is empty, the constraints are applied to
%   all entities in the model. If `recombine' is true, the recombine flag is
%   automatically set on the transfinite surfaces.
%
%   Inputs:
%     dimTags - Nx2 matrix of (dim,tag) (default zeros(0,2))
%     cornerAngle - double scalar (default 2.35)
%     recombine - logical scalar (default true)

    arguments
        dimTags = zeros(0,2)
        cornerAngle (1,1) double = 2.35
        recombine (1,1) logical = true
    end

    gmsh.internal.api.call('gmshModelMeshSetTransfiniteAutomatic', dimTags, cornerAngle, recombine);
end
