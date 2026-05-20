function classifySurfaces(angle, boundary, forReparametrization, curveAngle, exportDiscrete)
%CLASSIFYSURFACES  gmsh.model.mesh.classifySurfaces
%   Classify ("color") the surface mesh based on the angle threshold `angle' (in
%   radians), and create new discrete surfaces, curves and points accordingly.
%   If `boundary' is set, also create discrete curves on the boundary if the
%   surface is open. If `forReparametrization' is set, create curves and
%   surfaces that can be reparametrized using a single map. If `curveAngle' is
%   less than Pi, also force curves to be split according to `curveAngle'. If
%   `exportDiscrete' is set, clear any built-in CAD kernel entities and export
%   the discrete entities in the built-in CAD kernel.
%
%   Inputs:
%     angle - double scalar
%     boundary - logical scalar (default true)
%     forReparametrization - logical scalar (default false)
%     curveAngle - double scalar (default pi)
%     exportDiscrete - logical scalar (default true)

    arguments
        angle (1,1) double
        boundary (1,1) logical = true
        forReparametrization (1,1) logical = false
        curveAngle (1,1) double = pi
        exportDiscrete (1,1) logical = true
    end

    gmsh.internal.api.call('gmshModelMeshClassifySurfaces', angle, boundary, forReparametrization, curveAngle, exportDiscrete);
end
