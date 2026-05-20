function copy(refTag, tag)
%COPY  gmsh.view.option.copy
%   Copy the options from the view with tag `refTag' to the view with tag `tag'.
%
%   Inputs:
%     refTag - integer scalar
%     tag - integer scalar

    arguments
        refTag (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    gmsh.internal.api.call('gmshViewOptionCopy', refTag, tag);
end
