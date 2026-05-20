function [values, distance] = probe(tag, x, y, z, step, numComp, gradient, distanceMax, xElemCoord, yElemCoord, zElemCoord, dim)
%PROBE  gmsh.view.probe
%   Probe the view `tag' for its `values' at point (`x', `y', `z'). If no match
%   is found, `value' is returned empty. Return only the value at step `step' is
%   `step' is positive. Return only values with `numComp' if `numComp' is
%   positive. Return the gradient of the `values' if `gradient' is set. If
%   `distanceMax' is zero, only return a result if an exact match inside an
%   element in the view is found; if `distanceMax' is positive and an exact
%   match is not found, return the value at the closest node if it is closer
%   than `distanceMax'; if `distanceMax' is negative and an exact match is not
%   found, always return the value at the closest node. The distance to the
%   match is returned in `distance'. Return the result from the element
%   described by its coordinates if `xElementCoord', `yElementCoord' and
%   `zElementCoord' are provided. If `dim' is >= 0, return only matches from
%   elements of the specified dimension.
%
%   Inputs:
%     tag - integer scalar
%     x - double scalar
%     y - double scalar
%     z - double scalar
%     step - integer scalar (default -1)
%     numComp - integer scalar (default -1)
%     gradient - logical scalar (default false)
%     distanceMax - double scalar (default 0.)
%     xElemCoord - vector of doubles (default [])
%     yElemCoord - vector of doubles (default [])
%     zElemCoord - vector of doubles (default [])
%     dim - integer scalar (default -1)
%
%   Outputs:
%     values - row vector of doubles
%     distance - double scalar

    arguments
        tag (1,1) {mustBeInteger}
        x (1,1) double
        y (1,1) double
        z (1,1) double
        step (1,1) {mustBeInteger} = -1
        numComp (1,1) {mustBeInteger} = -1
        gradient (1,1) logical = false
        distanceMax (1,1) double = 0.
        xElemCoord = []
        yElemCoord = []
        zElemCoord = []
        dim (1,1) {mustBeInteger} = -1
    end

    [values, distance] = gmsh.internal.api.call('gmshViewProbe', tag, x, y, z, step, numComp, gradient, distanceMax, xElemCoord, yElemCoord, zElemCoord, dim);
end
