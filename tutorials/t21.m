% Gmsh MATLAB tutorial 21 — Mesh partitioning.

gmsh.initialize();
gmsh.model.add("t21");
gmsh.model.occ.addRectangle(0, 0, 0, 1, 1, 1, 0);
gmsh.model.occ.addRectangle(1, 0, 0, 1, 1, 2, 0);
gmsh.model.occ.fragment([2 1], [2 2], -1, true, true);
gmsh.model.occ.synchronize();
gmsh.model.mesh.setSize(gmsh.model.getEntities(0), 0.05);

gmsh.model.addPhysicalGroup(2, [1], 100, "Left");
gmsh.model.addPhysicalGroup(2, [2], 200, "Right");
gmsh.model.mesh.generate(2);

gmsh.onelab.set(['[', ...
  '{"type":"number","name":"Parameters/0Mesh partitioner","values":[0],"choices":[0,1],"valueLabels":{"Metis":0,"SimplePartition":1}},', ...
  '{"type":"number","name":"Parameters/1Number of partitions","values":[3],"min":1,"max":256,"step":1},', ...
  '{"type":"number","name":"Parameters/2Create partition topology (BRep)?","values":[1],"choices":[0,1]},', ...
  '{"type":"number","name":"Parameters/3Create ghost cells?","values":[0],"choices":[0,1]},', ...
  '{"type":"number","name":"Parameters/3Create new physical groups?","values":[0],"choices":[0,1]},', ...
  '{"type":"number","name":"Parameters/3Write file to disk?","values":[1],"choices":[0,1]},', ...
  '{"type":"number","name":"Parameters/4Write one file per partition?","values":[0],"choices":[0,1]}', ...
  ']']);

partitionMesh();
gmsh.finalize();

function partitionMesh()
    N = gmsh.onelab.getNumber("Parameters/1Number of partitions");
    N = int32(N(1));

    v = gmsh.onelab.getNumber("Parameters/2Create partition topology (BRep)?");
    gmsh.option.setNumber("Mesh.PartitionCreateTopology", v(1));

    v = gmsh.onelab.getNumber("Parameters/3Create ghost cells?");
    gmsh.option.setNumber("Mesh.PartitionCreateGhostCells", v(1));

    v = gmsh.onelab.getNumber("Parameters/3Create new physical groups?");
    gmsh.option.setNumber("Mesh.PartitionCreatePhysicals", v(1));

    gmsh.option.setNumber("Mesh.PartitionOldStyleMsh2", 0);

    v = gmsh.onelab.getNumber("Parameters/4Write one file per partition?");
    gmsh.option.setNumber("Mesh.PartitionSplitMeshFiles", v(1));

    partitioner = gmsh.onelab.getNumber("Parameters/0Mesh partitioner");
    if partitioner(1) == 0
        gmsh.model.mesh.partition(N, [], []);
    else
        gmsh.plugin.setNumber("SimplePartition", "NumSlicesX", N);
        gmsh.plugin.setNumber("SimplePartition", "NumSlicesY", 1);
        gmsh.plugin.setNumber("SimplePartition", "NumSlicesZ", 1);
        gmsh.plugin.run("SimplePartition");
    end

    writeFile = gmsh.onelab.getNumber("Parameters/3Write file to disk?");
    if writeFile(1) == 1
        gmsh.write("t21.msh");
    end
end
