% -----------------------------------------------------------------------------
%
%  Gmsh MATLAB extended tutorial 6
%
%  Additional mesh data: integration points, Jacobians and basis functions
%
% -----------------------------------------------------------------------------

gmsh.initialize();

gmsh.model.add("x6");

% Simple meshed rectangle.
gmsh.model.occ.addRectangle(0, 0, 0, 1, 0.1);
gmsh.model.occ.synchronize();
gmsh.model.mesh.setTransfiniteAutomatic();
gmsh.model.mesh.generate(2);

elementOrder        = 1;
interpolationOrder  = 2;
gmsh.model.mesh.setOrder(elementOrder);

elementTypes = gmsh.model.mesh.getElementTypes();
for t = elementTypes
    [elementName, ~, ~, ~, ~, ~] = gmsh.model.mesh.getElementProperties(t);
    fprintf('\n** %s **\n\n', elementName);

    [localCoords, ~] = gmsh.model.mesh.getIntegrationPoints( ...
        t, sprintf('Gauss%d', interpolationOrder));
    pp(sprintf('integration points to integrate order %d polynomials', ...
        interpolationOrder), localCoords, 3);

    [~, basisFunctions, ~] = gmsh.model.mesh.getBasisFunctions( ...
        t, localCoords, "Lagrange");
    pp('basis functions at integration points', basisFunctions, 1);

    [~, basisFunctions, ~] = gmsh.model.mesh.getBasisFunctions( ...
        t, localCoords, "GradLagrange");
    pp('basis function gradients at integration points', basisFunctions, 3);

    [~, determinants, ~] = gmsh.model.mesh.getJacobians(t, localCoords);
    pp('Jacobian determinants at integration points', determinants, 1);
end

gmsh.finalize();

function pp(label, v, mult)
    fprintf(' * %g %s: %s\n', numel(v) / mult, label, mat2str(v));
end
