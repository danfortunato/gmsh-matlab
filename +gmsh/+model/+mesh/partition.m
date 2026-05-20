function partition(numPart, elementTags, partitions)
%PARTITION  gmsh.model.mesh.partition
%   Partition the mesh of the current model into `numPart' partitions.
%   Optionally, `elementTags' and `partitions' can be provided to specify the
%   partition of each element explicitly.
%
%   Inputs:
%     numPart - integer scalar
%     elementTags - vector of size_t (default uint64([]))
%     partitions - vector of integers (default int32([]))

    arguments
        numPart (1,1) {mustBeInteger}
        elementTags = uint64([])
        partitions = int32([])
    end

    gmsh.internal.api.call('gmshModelMeshPartition', numPart, elementTags, partitions);
end
