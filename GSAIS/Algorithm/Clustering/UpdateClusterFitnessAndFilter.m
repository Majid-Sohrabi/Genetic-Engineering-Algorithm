function [Clusters, updatedAvgCosts] = UpdateClusterFitnessAndFilter(Clusters, Info)
% Updates cluster average fitness considering predator-prey interactions
% and removes clusters with negative updated fitness or fewer than 10 individuals.
%
% INPUTS:
%   Clusters - Struct array with fields: Type, Fitness, Chromosomes
%   Info     - Struct with fields: alpha, gamma
%
% OUTPUTS:
%   Clusters         - Filtered cluster struct array
%   updatedAvgCosts  - Array of updated fitness values (for reference)

    numClusters = length(Clusters);
    ClusterFitness = [Clusters.Fitness];
    updatedAvgCosts = ClusterFitness;  % Initialize

    for i = 1:numClusters
        for j = 1:numClusters
            if i == j, continue; end

            if strcmp(Clusters(i).Type, Clusters(j).Type)
                updatedAvgCosts(i) = updatedAvgCosts(i) - Info.alpha * ClusterFitness(j);
            elseif strcmp(Clusters(i).Type, 'Predator') && strcmp(Clusters(j).Type, 'Prey')
                updatedAvgCosts(i) = updatedAvgCosts(i) + Info.gamma * ClusterFitness(j);
            elseif strcmp(Clusters(i).Type, 'Prey') && strcmp(Clusters(j).Type, 'Predator')
                updatedAvgCosts(i) = updatedAvgCosts(i) - Info.gamma * ClusterFitness(j);
            end
        end
    end

    % Store updated fitness
    for i = 1:numClusters
        Clusters(i).UpdatedAvgCost = updatedAvgCosts(i);
    end

    % Filter out invalid clusters (negative fitness or <10 individuals)
    isValid = arrayfun(@(c) c.UpdatedAvgCost >= 0 && size(c.Chromosomes, 1) >= 20, Clusters);
    % isValid = arrayfun(@(c) size(c.Chromosomes, 1) >= max(2, round(0.05 * Info.Npop)), Clusters);
    Clusters = Clusters(isValid);
    updatedAvgCosts = updatedAvgCosts(isValid);  % Return only valid values
end