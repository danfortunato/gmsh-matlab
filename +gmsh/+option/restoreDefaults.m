function restoreDefaults()
%RESTOREDEFAULTS  gmsh.option.restoreDefaults
%   Restore all options to default settings.

    gmsh.internal.api.call('gmshOptionRestoreDefaults');
end
