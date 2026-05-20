function elementsQuality = getElementQualities(elementTags, qualityName, task, numTasks)
%GETELEMENTQUALITIES  gmsh.model.mesh.getElementQualities
%   Get the quality `elementQualities' of the elements with tags `elementTags'.
%   `qualityType' is the requested quality measure: "minDetJac" and "maxDetJac"
%   for the adaptively computed minimal and maximal Jacobian determinant,
%   "minSJ" for the sampled minimal scaled jacobien, "minSICN" for the sampled
%   minimal signed inverted condition number, "minSIGE" for the sampled signed
%   inverted gradient error, "gamma" for the ratio of the inscribed to
%   circumcribed sphere radius, "innerRadius" for the inner radius,
%   "outerRadius" for the outerRadius, "minIsotropy" for the minimum isotropy
%   measure, "angleShape" for the angle shape measure, "minEdge" for the minimum
%   straight edge length, "maxEdge" for the maximum straight edge length,
%   "volume" for the volume. If `numTasks' > 1, only compute and return the part
%   of the data indexed by `task' (for C++ only; output vector must be
%   preallocated).
%
%   Inputs:
%     elementTags - vector of size_t
%     qualityName - string (default "minSICN")
%     task - size_t scalar (default 0)
%     numTasks - size_t scalar (default 1)
%
%   Outputs:
%     elementsQuality - row vector of doubles

    arguments
        elementTags
        qualityName (1,:) char = "minSICN"
        task (1,1) {mustBeInteger, mustBeNonnegative} = 0
        numTasks (1,1) {mustBeInteger, mustBeNonnegative} = 1
    end

    elementsQuality = gmsh.internal.api.call('gmshModelMeshGetElementQualities', elementTags, qualityName, task, numTasks);
end
