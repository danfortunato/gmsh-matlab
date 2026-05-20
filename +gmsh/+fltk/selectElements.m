function [ret, elementTags] = selectElements()
%SELECTELEMENTS  gmsh.fltk.selectElements
%   Select elements in the user interface.
%
%   Outputs:
%     ret - integer scalar
%     elementTags - row vector of uint64

    [ret, elementTags] = gmsh.internal.api.call('gmshFltkSelectElements');
end
