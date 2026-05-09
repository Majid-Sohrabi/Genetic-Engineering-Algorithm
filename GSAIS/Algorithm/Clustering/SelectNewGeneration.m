function pop = SelectNewGeneration(Clusters, selectionProportions, Info, pop_random, BestSol, costfunction, popMatrix)
% Updated version with full 4-step pipeline and dimension safety

    newGeneration = [];
    newFitnessList = [];
    nClusters = length(Clusters);
    meaningfulClusterCount = 0;
    hasAddedPopRandom = false;

    %% Step 1: Select individuals from each cluster by proportion
    for i = 1:nClusters
        cluster_pop = Clusters(i).Chromosomes;
        fitness_values = Clusters(i).Individual_Costs;

        if isempty(cluster_pop) || size(cluster_pop, 1) < 2
            fprintf('Cluster %d has insufficient population (less than 2). Skipping.\n', i);
            continue;
        end

        meaningfulClusterCount = meaningfulClusterCount + 1;

        [sorted_fitness, sorted_idx] = sort(fitness_values);
        sorted_cluster_pop = cluster_pop(sorted_idx, :);

        num_selected = min(round(selectionProportions(i) * Info.Npop), size(sorted_cluster_pop, 1));
        num_selected = max(num_selected, 1);

        selected_individuals = sorted_cluster_pop(1:num_selected, :);
        selected_fitness = sorted_fitness(1:num_selected);

        for j = 1:size(selected_individuals, 1)
            candidate = reshape(selected_individuals(j, :), 1, []);
            if isempty(newGeneration) || size(candidate, 2) == size(newGeneration, 2)
                if isempty(newGeneration) || ~ismember(candidate, newGeneration, 'rows')
                    newGeneration = [newGeneration; candidate];
                    newFitnessList = [newFitnessList; selected_fitness(j)];
                end
            end
        end
    end

    %% Step 2: Elite preservation + inter-cluster crossover
    
    bestIndividuals = [];
    bestCosts = [];
    
    %% ---- (A) Store best individual from each cluster (elitism) ----
    for i = 1:nClusters
        cluster_pop = Clusters(i).Chromosomes;
        fitness_values = Clusters(i).Individual_Costs;
    
        if isempty(cluster_pop) || size(cluster_pop,1) < 2
            continue;
        end
    
        [min_fitness, idx] = min(fitness_values);
        best_individual = reshape(cluster_pop(idx,:),1,[]);
    
        % Store elite in new generation
        if isempty(newGeneration) || ...
           (size(best_individual,2) == size(newGeneration,2) && ...
            ~ismember(best_individual, newGeneration, 'rows'))
    
            newGeneration = [newGeneration; best_individual];
            newFitnessList = [newFitnessList; min_fitness];
        end
    
        % Save for crossover
        bestIndividuals = [bestIndividuals; best_individual];
        bestCosts = [bestCosts; min_fitness];
    end
    
    %% ---- (B) Inter-cluster crossover among best individuals ----
    nBest = size(bestIndividuals,1);
    
    for i = 1:nBest
        for j = i+1:nBest
    
            parents = [bestIndividuals(i,:); bestIndividuals(j,:)];
    
            [child1, child2] = Crossover(parents, Info.Crossover_gamma, Info.Model, popMatrix);
    
            % Child 1
            cost1 = costfunction(child1);
            if cost1 ~= inf
                child1 = reshape(child1,1,[]);
                if isempty(newGeneration) || ...
                   (size(child1,2) == size(newGeneration,2) && ...
                    ~ismember(child1, newGeneration, 'rows'))
                    newGeneration = [newGeneration; child1];
                    newFitnessList = [newFitnessList; cost1];
                end
            end
            % Child 2
            cost2 = costfunction(child2);
            if cost2 ~= inf
                child2 = reshape(child2,1,[]);
                if isempty(newGeneration) || ...
                   (size(child2,2) == size(newGeneration,2) && ...
                    ~ismember(child2, newGeneration, 'rows'))
                    newGeneration = [newGeneration; child2];
                    newFitnessList = [newFitnessList; cost2];
                end
            end
        end
    end

    %% Step 3: Inject pop_random if too few clusters AND newGeneration too small
    if meaningfulClusterCount < 2 && size(newGeneration, 1) < 20 && ~isempty(pop_random) && ~hasAddedPopRandom
        for k = 1:length(pop_random)
            rand_individual = reshape(pop_random(k).Position, 1, []);
            rand_cost = pop_random(k).Cost;

            if isempty(newGeneration) || size(rand_individual, 2) == size(newGeneration, 2)
                if isempty(newGeneration) || ~ismember(rand_individual, newGeneration, 'rows')
                    newGeneration = [newGeneration; rand_individual];
                    newFitnessList = [newFitnessList; rand_cost];
                end
            end
        end
        hasAddedPopRandom = true;
    end

    %% Final sort and formatting
    [~, final_sorted_idx] = sort(newFitnessList);
    newGeneration = newGeneration(final_sorted_idx, :);
    newFitnessList = newFitnessList(final_sorted_idx);

    %% Output population structure
    pop = repmat(struct('Position', [], 'Cost', []), Info.Npop, 1);
    for i = 1:Info.Npop
        if i <= size(newGeneration, 1)
            pop(i).Position = newGeneration(i, :);
            pop(i).Cost = newFitnessList(i);
        else
            % In case of a mismatch, fill default
            if ~isempty(Clusters) && isfield(Clusters, 'Chromosomes') && ~isempty(Clusters(1).Chromosomes)
                chromosomeLength = size(Clusters(1).Chromosomes, 2);
            else
                chromosomeLength = Info.Model.Dimension;  % Fallback
            end
            % pop(i).Position = zeros(1, chromosomeLength);
            % pop(i).Cost = inf;

            pop(i).Position = Mutation(BestSol.Position, Info.Mutation_gamma, Info.Model, BestSol, toc, Info.TimeLimit);
            % Evaluation
            pop(i).Cost=costfunction(pop(i).Position);
        end
    end

end