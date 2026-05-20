function awake(action)
%AWAKE  gmsh.fltk.awake
%   Awake the main user interface thread and process pending events, and
%   optionally perform an action (currently the only `action' allowed is
%   "update").
%
%   Inputs:
%     action - string (default '')

    arguments
        action (1,:) char = ''
    end

    gmsh.internal.api.call('gmshFltkAwake', action);
end
