function createTopology(makeSimplyConnected, exportDiscrete)
%CREATETOPOLOGY  gmsh.model.mesh.createTopology
%   Create a boundary representation from the mesh if the model does not have
%   one (e.g. when imported from mesh file formats with no BRep representation
%   of the underlying model). If `makeSimplyConnected' is set, enforce simply
%   connected discrete surfaces and volumes. If `exportDiscrete' is set, clear
%   any built-in CAD kernel entities and export the discrete entities in the
%   built-in CAD kernel.
%
%   Inputs:
%     makeSimplyConnected - logical scalar (default true)
%     exportDiscrete - logical scalar (default true)

    arguments
        makeSimplyConnected (1,1) logical = true
        exportDiscrete (1,1) logical = true
    end

    gmsh.internal.api.call('gmshModelMeshCreateTopology', makeSimplyConnected, exportDiscrete);
end
