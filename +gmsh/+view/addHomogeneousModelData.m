function addHomogeneousModelData(tag, step, modelName, dataType, tags, data, time, numComponents, partition)
%ADDHOMOGENEOUSMODELDATA  gmsh.view.addHomogeneousModelData
%   Add homogeneous model-based post-processing data to the view with tag `tag'.
%   The arguments have the same meaning as in `addModelData', except that `data'
%   is supposed to be homogeneous and is thus flattened in a single vector. For
%   data types that can lead to different data sizes per tag (like
%   "ElementNodeData"), the data should be padded.
%
%   Inputs:
%     tag - integer scalar
%     step - integer scalar
%     modelName - string
%     dataType - string
%     tags - vector of size_t
%     data - vector of doubles
%     time - double scalar (default 0.)
%     numComponents - integer scalar (default -1)
%     partition - integer scalar (default 0)

    arguments
        tag (1,1) {mustBeInteger}
        step (1,1) {mustBeInteger}
        modelName (1,:) char
        dataType (1,:) char
        tags
        data
        time (1,1) double = 0.
        numComponents (1,1) {mustBeInteger} = -1
        partition (1,1) {mustBeInteger} = 0
    end

    gmsh.internal.api.call('gmshViewAddHomogeneousModelData', tag, step, modelName, dataType, tags, data, time, numComponents, partition);
end
