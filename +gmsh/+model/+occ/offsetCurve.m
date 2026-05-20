function outDimTags = offsetCurve(curveLoopTag, offset)
%OFFSETCURVE  gmsh.model.occ.offsetCurve
%   Create an offset curve based on the curve loop `curveLoopTag' with offset
%   `offset'. Return the offset curves in `outDimTags' as a vector of (dim, tag)
%   pairs.
%
%   Inputs:
%     curveLoopTag - integer scalar
%     offset - double scalar
%
%   Outputs:
%     outDimTags - Nx2 matrix of (dim,tag) pairs

    arguments
        curveLoopTag (1,1) {mustBeInteger}
        offset (1,1) double
    end

    outDimTags = gmsh.internal.api.call('gmshModelOccOffsetCurve', curveLoopTag, offset);
end
