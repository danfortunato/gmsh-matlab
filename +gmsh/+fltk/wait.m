function wait(time)
%WAIT  gmsh.fltk.wait
%   Wait at most `time' seconds for user interface events and return. If `time'
%   < 0, wait indefinitely. First automatically create the user interface if it
%   has not yet been initialized. Can only be called in the main thread.
%
%   Inputs:
%     time - double scalar (default -1.)

    arguments
        time (1,1) double = -1.
    end

    gmsh.internal.api.call('gmshFltkWait', time);
end
