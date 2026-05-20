% gui.m
%
% Port of gui.py. The Python version exits immediately when invoked with
% -nopopup, otherwise drives the FLTK GUI. On macOS inside MATLAB the GUI
% calls conflict with the Cocoa main thread, so we mirror the Python
% -nopopup branch and exit without setting up any geometry.
return
