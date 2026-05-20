function addModelData(tag, step, modelName, dataType, tags, data, time, numComponents, partition)
%ADDMODELDATA  gmsh.view.addModelData
%   Add model-based post-processing data to the view with tag `tag'. `modelName'
%   identifies the model the data is attached to. `dataType' specifies the type
%   of data, currently either "NodeData", "ElementData" or "ElementNodeData".
%   `step' specifies the identifier (>= 0) of the data in a sequence. `tags'
%   gives the tags of the nodes or elements in the mesh to which the data is
%   associated. `data' is a vector of the same length as `tags': each entry is
%   the vector of double precision numbers representing the data associated with
%   the corresponding tag. The optional `time' argument associate a time value
%   with the data. `numComponents' gives the number of data components (1 for
%   scalar data, 3 for vector data, etc.) per entity; if negative, it is
%   automatically inferred (when possible) from the input data. `partition'
%   allows one to specify data in several sub-sets.
%
%   Inputs:
%     tag - integer scalar
%     step - integer scalar
%     modelName - string
%     dataType - string
%     tags - vector of size_t
%     data - cell of double vectors
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

    gmsh.internal.api.call('gmshViewAddModelData', tag, step, modelName, dataType, tags, data, time, numComponents, partition);
end
