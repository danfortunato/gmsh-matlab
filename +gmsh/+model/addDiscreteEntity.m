function ret = addDiscreteEntity(dim, tag, boundary)
%ADDDISCRETEENTITY  gmsh.model.addDiscreteEntity
%   Add a discrete model entity (defined by a mesh) of dimension `dim' in the
%   current model. Return the tag of the new discrete entity, equal to `tag' if
%   `tag' is positive, or a new tag if `tag' < 0. `boundary' specifies the tags
%   of the entities on the boundary of the discrete entity, if any. Specifying
%   `boundary' allows Gmsh to construct the topology of the overall model.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar (default -1)
%     boundary - vector of integers (default int32([]))
%
%   Outputs:
%     ret - integer scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger} = -1
        boundary = int32([])
    end

    ret = gmsh.internal.api.call('gmshModelAddDiscreteEntity', dim, tag, boundary);
end
