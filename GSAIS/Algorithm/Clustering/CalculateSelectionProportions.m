function selectionProportions = CalculateSelectionProportions(Clusters)
    updatedCosts = [Clusters.UpdatedAvgCost];

    % Shift and scale to [0, 1] range
    minCost = min(updatedCosts);
    maxCost = max(updatedCosts);
    
    if maxCost == minCost
        % Avoid division by zero if all values are equal
        selectionProportions = ones(size(updatedCosts)) / length(updatedCosts);
    else
        fitness = 1 ./ (updatedCosts + 1e-12);   % minimization → invert
        selectionProportions = fitness / sum(fitness);
    end
end

