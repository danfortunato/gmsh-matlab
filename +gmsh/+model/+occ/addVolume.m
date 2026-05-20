function ret = addVolume(shellTags, tag)
%ADDVOLUME  gmsh.model.occ.addVolume
%   Add a volume (a region) in the OpenCASCADE CAD representation, defined by
%   one or more surface loops `shellTags'. The first surface loop defines the
%   exterior boundary; additional surface loop define holes. If `tag' is
%   positive, set the tag explicitly; otherwise a new tag is selected
%   automatically. Return the tag of the volume.
%
%   Inputs:
%     shellTags - vector of integers
%     tag - integer scalar (default -1)
%
%   Outputs:
%     ret - integer scalar

    arguments
        shellTags
        tag (1,1) {mustBeInteger} = -1
    end

    ret = gmsh.internal.api.call('gmshModelOccAddVolume', shellTags, tag);
end
