function [dataType, tags, data, time, numComponents] = getModelData(tag, step)
%GETMODELDATA  gmsh.view.getModelData
%   Get model-based post-processing data from the view with tag `tag' at step
%   `step'. Return the `data' associated to the nodes or the elements with tags
%   `tags', as well as the `dataType' and the number of components
%   `numComponents'.
%
%   Inputs:
%     tag - integer scalar
%     step - integer scalar
%
%   Outputs:
%     dataType - string
%     tags - row vector of uint64
%     data - cell of double row vectors
%     time - double scalar
%     numComponents - integer scalar

    arguments
        tag (1,1) {mustBeInteger}
        step (1,1) {mustBeInteger}
    end

    [dataType, tags, data, time, numComponents] = gmsh.internal.api.call('gmshViewGetModelData', tag, step);
end
