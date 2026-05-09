function Clusters = AssignPredatorPreyRoles(Clusters, Npop, gamma)
% AssignPredatorPreyRoles assigns each cluster a role: 'Predator' or 'Prey'
% using a probabilistic method based on cluster size and a constant γ.
%
% INPUTS:
%   Clusters - Struct array with field Chromosomes (to get N_i)
%   Npop     - Total number of individuals in the population
%   gamma    - Constant (e.g., 0.25)
%
% OUTPUT:
%   Clusters - Updated struct with new field 'Type' = 'Predator' or 'Prey'

    costs = [Clusters.Fitness];
    [~, order] = sort(costs); % lower is better
    
    numPredators = max(1, round(0.3 * length(Clusters)));
    
    for i = 1:length(Clusters)
        if ismember(i, order(1:numPredators))
            Clusters(i).Type = 'Predator';  % best clusters
        else
            Clusters(i).Type = 'Prey';
        end
    end
end
