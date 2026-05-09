function [bestLabels, bestK, silhouetteValues, popLabels_k, silhouetteHistory, Clusters] = PerformDBSCANWithSilhouette(popMatrix, pop, Info)
% Perform DBSCAN clustering for GSAIS with the same outputs as k-means version

% eps = Info.DBSCAN_eps;      % e.g., 0.5
% MinPts = Info.DBSCAN_MinPts; % e.g., 2

D = pdist(popMatrix, 'euclidean');
eps = Info.alpha_eps * median(D);

% Run DBSCAN
[idx, ~] = dbscan(popMatrix, eps, Info.MinPts);

% Convert -1 cluster (noise) to a valid cluster
uniqueClusters = unique(idx);
if any(uniqueClusters == -1)
    idx(idx == -1) = max(uniqueClusters) + 1;  % Assign -1 to a new cluster
end

% Make cluster indices consecutive 1..k
uniqueClusters = unique(idx);
bestLabels = zeros(size(idx));
for k = 1:length(uniqueClusters)
    bestLabels(idx == uniqueClusters(k)) = k;
end
bestK = length(uniqueClusters);

% Store labels (as cell for compatibility)
popLabels_k = {bestLabels};

% Compute Silhouette Scores
silhouetteValues = silhouette(popMatrix, bestLabels, 'sqeuclidean');
silhouetteHistory = silhouetteValues;

% Create Clusters structure
Clusters = struct();
for i = 1:bestK
    label = i;
    cluster_indices = find(bestLabels == label);
    Clusters(i).Label = label;
    Clusters(i).Chromosomes = popMatrix(cluster_indices, :);
    Clusters(i).Individual_Costs = [pop(cluster_indices).Cost]';
    Clusters(i).Fitness = mean(Clusters(i).Individual_Costs);
end

end