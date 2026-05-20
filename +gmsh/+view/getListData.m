function [dataType, numElements, data] = getListData(tag, returnAdaptive)
%GETLISTDATA  gmsh.view.getListData
%   Get list-based post-processing data from the view with tag `tag'. Return the
%   types `dataTypes', the number of elements `numElements' for each data type
%   and the `data' for each data type. If `returnAdaptive' is set, return the
%   data obtained after adaptive refinement, if available.
%
%   Inputs:
%     tag - integer scalar
%     returnAdaptive - logical scalar (default false)
%
%   Outputs:
%     dataType - cell of strings
%     numElements - row vector of int32
%     data - cell of double row vectors

    arguments
        tag (1,1) {mustBeInteger}
        returnAdaptive (1,1) logical = false
    end

    [dataType, numElements, data] = gmsh.internal.api.call('gmshViewGetListData', tag, returnAdaptive);
end
