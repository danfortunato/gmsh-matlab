function addHomologyRequest(kind, domainTags, subdomainTags, dims)
%ADDHOMOLOGYREQUEST  gmsh.model.mesh.addHomologyRequest
%   Add a request to compute a basis representation for homology spaces (if
%   `type' == "Homology") or cohomology spaces (if `type' == "Cohomology"). The
%   computation domain is given in a list of physical group tags `domainTags';
%   if empty, the whole mesh is the domain. The computation subdomain for
%   relative (co)homology computation is given in a list of physical group tags
%   `subdomainTags'; if empty, absolute (co)homology is computed. The dimensions
%   of the (co)homology bases to be computed are given in the list `dim'; if
%   empty, all bases are computed. Resulting basis representation (co)chains are
%   stored as physical groups in the mesh. If the request is added before mesh
%   generation, the computation will be performed at the end of the meshing
%   pipeline.
%
%   Inputs:
%     kind - string (default "Homology")
%     domainTags - vector of integers (default int32([]))
%     subdomainTags - vector of integers (default int32([]))
%     dims - vector of integers (default int32([]))

    arguments
        kind (1,:) char = "Homology"
        domainTags = int32([])
        subdomainTags = int32([])
        dims = int32([])
    end

    gmsh.internal.api.call('gmshModelMeshAddHomologyRequest', kind, domainTags, subdomainTags, dims);
end
