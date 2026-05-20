function ex_partition(varargin)
%EX_PARTITION  Port of partition.py (renamed from partition to avoid
%   shadowing the Parallel Computing Toolbox / tall-array partition).
%   Optional name-value pairs:
%       'write_file'                   (logical, default false)
%       'write_one_file_per_partition' (logical, default false)
%       'partition_using_metis'        (logical, default false)
    p = inputParser;
    addParameter(p, 'write_file',                   false, @islogical);
    addParameter(p, 'write_one_file_per_partition', false, @islogical);
    addParameter(p, 'partition_using_metis',        false, @islogical);
    parse(p, varargin{:});
    args = p.Results;

    gmsh.initialize();

    gmsh.model.add("test");
    gmsh.model.occ.addRectangle(0, 0, 0, 1, 1);
    gmsh.model.occ.synchronize();
    gmsh.model.mesh.generate(2);

    if args.partition_using_metis
        gmsh.model.mesh.partition(3);
    else
        gmsh.plugin.setNumber("SimplePartition", "NumSlicesX", 3.);
        gmsh.plugin.run("SimplePartition");
    end

    if args.write_file
        if args.write_one_file_per_partition
            gmsh.option.setNumber("Mesh.PartitionSplitMeshFiles", 1);
        end
        gmsh.write("partition.msh");
    end

    entities = gmsh.model.getEntities();
    for k = 1:size(entities, 1)
        dim = entities(k, 1); tag = entities(k, 2);
        partitions = gmsh.model.getPartitions(dim, tag);
        if ~isempty(partitions)
            fprintf('Entity (%d, %d) of type %s\n', ...
                dim, tag, gmsh.model.getType(dim, tag));
            fprintf(' - Partition(s): %s\n', mat2str(partitions));
            [parentDim, parentTag] = gmsh.model.getParent(dim, tag);
            fprintf(' - Parent: (%d, %d)\n', parentDim, parentTag);
            boundary = gmsh.model.getBoundary(entities(k, :));
            fprintf(' - Boundary: (%d, 2)\n', size(boundary, 1));
        end
    end

    gmsh.finalize();
end
