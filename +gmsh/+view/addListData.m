function addListData(tag, dataType, numEle, data)
%ADDLISTDATA  gmsh.view.addListData
%   Add list-based post-processing data to the view with tag `tag'. List-based
%   datasets are independent from any model and any mesh. `dataType' identifies
%   the data by concatenating the field type ("S" for scalar, "V" for vector,
%   "T" for tensor) and the element type ("P" for point, "L" for line, "T" for
%   triangle, "S" for tetrahedron, "I" for prism, "H" for hexaHedron, "Y" for
%   pyramid). For example `dataType' should be "ST" for a scalar field on
%   triangles. `numEle' gives the number of elements in the data. `data'
%   contains the data for the `numEle' elements, concatenated, with node
%   coordinates followed by values per node, repeated for each step: [e1x1, ...,
%   e1xn, e1y1, ..., e1yn, e1z1, ..., e1zn, e1v1..., e1vN, e2x1, ...].
%
%   Inputs:
%     tag - integer scalar
%     dataType - string
%     numEle - integer scalar
%     data - vector of doubles

    arguments
        tag (1,1) {mustBeInteger}
        dataType (1,:) char
        numEle (1,1) {mustBeInteger}
        data
    end

    gmsh.internal.api.call('gmshViewAddListData', tag, dataType, numEle, data);
end
