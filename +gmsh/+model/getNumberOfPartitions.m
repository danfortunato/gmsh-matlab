function ret = getNumberOfPartitions()
%GETNUMBEROFPARTITIONS  gmsh.model.getNumberOfPartitions
%   Return the number of partitions in the model.
%
%   Outputs:
%     ret - integer scalar

    ret = gmsh.internal.api.call('gmshModelGetNumberOfPartitions');
end
