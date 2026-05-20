function [dataType, tags, data, time, numComponents] = getHomogeneousModelData(tag, step)
%GETHOMOGENEOUSMODELDATA  gmsh.view.getHomogeneousModelData
%   Get homogeneous model-based post-processing data from the view with tag
%   `tag' at step `step'. The arguments have the same meaning as in
%   `getModelData', except that `data' is returned flattened in a single vector,
%   with the appropriate padding if necessary.
%
%   Inputs:
%     tag - integer scalar
%     step - integer scalar
%
%   Outputs:
%     dataType - string
%     tags - row vector of uint64
%     data - row vector of doubles
%     time - double scalar
%     numComponents - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
        step (1,1) {mustBeInteger}
    end

    [dataType, tags, data, time, numComponents] = gmsh.internal.api.call('gmshViewGetHomogeneousModelData', tag, step);
end
