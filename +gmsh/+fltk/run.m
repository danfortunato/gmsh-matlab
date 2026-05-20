function run(optionFileName)
%RUN  gmsh.fltk.run
%   Run the event loop of the graphical user interface, i.e. repeatedly call
%   `wait()'. First automatically create the user interface if it has not yet
%   been initialized. If an `optionFileName' is given, load it before entering
%   the loop, and save all options and visibility information into it after
%   exiting the loop. Can only be called in the main thread.
%
%   Inputs:
%     optionFileName - string (default '')

    arguments
        optionFileName (1,:) char = ''
    end

    gmsh.internal.api.call('gmshFltkRun', optionFileName);
end
