function partitions = getPartitions(dim, tag)
%GETPARTITIONS  gmsh.model.getPartitions
%   In a partitioned model, return the tags of the partition(s) to which the
%   entity belongs.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     partitions - row vector of int32

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    partitions = gmsh.internal.api.call('gmshModelGetPartitions', dim, tag);
end
