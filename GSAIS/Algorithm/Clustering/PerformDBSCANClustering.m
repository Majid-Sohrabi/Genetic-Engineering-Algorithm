function [bestLabels, Clusters] = PerformDBSCANClustering(popMatrix, Info)
% Perform DBSCAN clustering on population matrix for GSAIS
% INPUT:
%   popMatrix : Npop x chromosome_length
%   Info      : algorithm parameters, including DBSCAN settings
% OUTPUT:
%   bestLabels: cluster assignment for each individual
%   Clusters  : structure array containing individuals per cluster

% DBSCAN parameters (tune eps and MinPts)
eps = Info.DBSCAN_eps;        % e.g., 0.1 ~ 1.0 depending on scaling
MinPts = Info.DBSCAN_MinPts;  % e.g., 2 ~ 5

% Run DBSCAN
[idx, ~] = dbscan(popMatrix, eps, MinPts);

% Handle outliers (class -1) by assigning them to nearest cluster
outliers = find(idx == -1);
if ~isempty(outliers)
    validClusters = unique(idx(idx~=-1));
    for i = 1:length(outliers)
        o = outliers(i);
        % assign to nearest valid cluster centroid
        minDist = inf;
        assignedCluster = validClusters(1);
        for c = validClusters'
            members = popMatrix(idx==c, :);
            centroid = mean(members,1);
            dist = norm(popMatrix(o,:) - centroid);
            if dist < minDist
                minDist = dist;
                assignedCluster = c;
            end
        end
        idx(o) = assignedCluster;
    end
end

% Make cluster indices consecutive 1..k
uniqueClusters = unique(idx);
newLabels = zeros(size(idx));
for k = 1:length(uniqueClusters)
    newLabels(idx == uniqueClusters(k)) = k;
end
bestLabels = newLabels;

% Build cluster structure
numClusters = max(bestLabels);
Clusters = struct('Members', cell(numClusters,1), 'AvgCost', [], 'Role', []);
for k = 1:numClusters
    Clusters(k).Members = find(bestLabels == k);
    Clusters(k).AvgCost = [];
    Clusters(k).Role = ''; % predator/prey assigned later
end

end
