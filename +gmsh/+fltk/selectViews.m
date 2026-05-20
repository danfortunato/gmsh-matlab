function [ret, viewTags] = selectViews()
%SELECTVIEWS  gmsh.fltk.selectViews
%   Select views in the user interface.
%
%   Outputs:
%     ret - integer scalar
%     viewTags - row vector of int32

    [ret, viewTags] = gmsh.internal.api.call('gmshFltkSelectViews');
end
