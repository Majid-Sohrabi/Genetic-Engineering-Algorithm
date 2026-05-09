function [Ans, BestCost, pop]=Algorithm_GSAIS_DBSCAN_Benchmark(pop, Info, pop_random)

global NFE;
NFE=0;

%% initialization
costfunction=@(q)Cost(q,Info.Model);

BestCost=[];

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);
pop=pop(1:Info.Npop);

% Store Cost (just arbitarary - b/c we don't sort)
BestSol=pop(1);
WorstCost=pop(end).Cost;
beta=10;         % Selection Pressure (Roulette Wheel)

% Pre-allocate arrays for fixed k
clusterSize = Info.cluster_sizes;  % Should be a scalar now, e.g., 4

% Initialize Pop_random
individual.Position=[];
individual.Cost=[];

tic;  % Start timer

%% GSAIS-KMeans Main loop
for It = 1:Info.Iteration
    
    % Extract population matrix
    popMatrix = vertcat(pop.Position);
    
    % Call clustering function (with fixed cluster size)
    [bestLabels, ~, silhouetteValues, popLabels_k, ~, Clusters] = ...
    PerformDBSCANWithSilhouette(popMatrix, pop, Info);

    % Assign labels to population
    for i = 1:Info.Npop
        pop(i).Cluster = bestLabels(i);
    end

    % Assign predator and prey roles to clusters
    sortByFitness = true;  % Set to false if you want random assignment
    gamma2 = 0.25;
    Clusters = AssignPredatorPreyRoles(Clusters, Info.Npop, gamma2);

    %% Recalculate average fitness based on predator-prey interactions
    [Clusters, updatedAvgCosts] = UpdateClusterFitnessAndFilter(Clusters, Info);

    %% Determine Selection Proportions for the Next Generation
    selectionProportions = CalculateSelectionProportions(Clusters);
    % Optional: to get number of individuals per cluster for Npop = 100
    numIndividualsPerCluster = round(selectionProportions * Info.Npop);

    %% Offspring Generation per Cluster
    Clusters = GenerateClusterOffspring(Clusters, selectionProportions, Info, costfunction, BestSol, popMatrix);

    %% Update Population (Post-Crossover and Mutation)
    pop = SelectNewGeneration(Clusters, selectionProportions, Info, pop_random, BestSol, costfunction, popMatrix);

    %% Sort population and store the best solution
    Costs = [pop.Cost];
    [Costs, SortOrder] = sort(Costs);
    pop = pop(SortOrder);
    pop = pop(1:Info.Npop);

    WorstCost = max(WorstCost, pop(end).Cost);
    
    if pop(1).Cost < BestSol.Cost
        BestSol = pop(1);
    end

    % --- Local Search around Best Solution ---
    sigma = 0.01 * (Info.Model.Max - Info.Model.Min);
    
    for k = 1:5   % small local refinement
        newPos = BestSol.Position + sigma .* randn(size(BestSol.Position));
        
        % Apply bounds
        newPos = max(newPos, Info.Model.Min);
        newPos = min(newPos, Info.Model.Max);
        
        newCost = costfunction(newPos);
        
        if newCost < BestSol.Cost
            BestSol.Position = newPos;
            BestSol.Cost = newCost;
        end
    end

    BestCost(It,1) = BestSol.Cost;
    BestPosition = pop(1).Position;
    
    nfe(It) = NFE;
    
    % Display iteration information
    disp(['Iteration ' num2str(It) ', Best Cost = ' num2str(BestCost(It))]);
    
    time = toc;  % End timer
    if time >= Info.TimeLimit
        break;
    end
end
time;
Ans = BestCost(end,1);
BestCost;
BestSol;
end