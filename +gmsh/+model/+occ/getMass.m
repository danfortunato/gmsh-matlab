function mass = getMass(dim, tag)
%GETMASS  gmsh.model.occ.getMass
%   Get the mass of the OpenCASCADE entity of dimension `dim' and tag `tag'. If
%   no density is attached to the entity (the default), the value corresponds
%   respectively to the length, area and volume for `dim' = 1, 2 and 3.
%
%   Inputs:
%     dim - integer scalar
%     tag - integer scalar
%
%   Outputs:
%     mass - double scalar

    arguments
        dim (1,1) {mustBeInteger}
        tag (1,1) {mustBeInteger}
    end

    mass = gmsh.internal.api.call('gmshModelOccGetMass', dim, tag);
end
