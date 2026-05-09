function Clusters = GenerateClusterOffspring(Clusters, selectionProportions, Info, costfunction, BestSol, popMatrix)
% Generate offspring per cluster based on selection proportions
% Phase 1: Crossover only
% Phase 2: Mutation only

    Npop = Info.Npop;
    totalClusters = numel(Clusters);
    MaxTries = 5;  % Maximum attempts to generate valid offspring per child

    for i = 1:totalClusters
        clusterPop = Clusters(i).Chromosomes;
        clusterSize = size(clusterPop, 1);
   
        if clusterSize < Info.MinPts
            continue;  % Skip undersized clusters
        end

        % Determine how many individuals should be in the next generation
        numSelected = round(selectionProportions(i) * Npop);
        targetCount_Cross = round(Info.PCrossover * numSelected);
        targetCount_Mute = round(Info.PMutation * numSelected);

        % Initialize storage for valid offspring
        offspring = [];
        offspringCosts = [];

        %% =========================
        %% PHASE 1: CROSSOVER ONLY
        %% =========================
        tries = 0;
        while size(offspring,1) < targetCount_Cross && tries < MaxTries*numSelected

            % idx = randperm(clusterSize, 2);
            % parents = clusterPop(idx, :);
            i1 = TournamentSelection(Clusters(i).Individual_Costs, 3);
            i2 = TournamentSelection(Clusters(i).Individual_Costs, 3);
            parents = [clusterPop(i1,:); clusterPop(i2,:)];

            [child1, child2] = Crossover(parents, Info.Crossover_gamma, Info.Model, popMatrix);

            % Evaluate children
            cost1 = costfunction(child1);
            cost2 = costfunction(child2);

            if cost1 ~= inf
                offspring = [offspring; child1];
                offspringCosts = [offspringCosts; cost1];
            end

            if cost2 ~= inf && size(offspring,1) < targetCount_Cross
                offspring = [offspring; child2];
                offspringCosts = [offspringCosts; cost2];
            end
            tries = tries + 1;
        end

        %% =========================
        %% PHASE 2: MUTATION ONLY
        %% =========================
        tries = 0;
        while size(offspring,1) < targetCount_Mute && tries < MaxTries*numSelected

            % Select parent from cluster
            idx = randi(clusterSize);
            parent = clusterPop(idx, :);
            % Apply mutation only
            child = Mutation(parent, Info.Mutation_gamma, Info.Model, BestSol, toc, Info.TimeLimit);

            cost = costfunction(child);

            if cost ~= inf
                offspring = [offspring; child];
                offspringCosts = [offspringCosts; cost];
            end
            tries = tries + 1;
        end

        %% =========================
        %% APPEND OFFSPRING
        %% =========================
        Clusters(i).Chromosomes = ...
            [Clusters(i).Chromosomes; offspring];

        Clusters(i).Individual_Costs = ...
            [Clusters(i).Individual_Costs; offspringCosts];
    end
end