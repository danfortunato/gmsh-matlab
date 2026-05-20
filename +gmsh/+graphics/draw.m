function draw()
%DRAW  gmsh.graphics.draw
%   Draw all the OpenGL scenes.

    gmsh.internal.api.call('gmshGraphicsDraw');
end
