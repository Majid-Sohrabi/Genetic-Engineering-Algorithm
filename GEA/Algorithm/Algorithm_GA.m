function [Ans,BestCost,pop]=Algorithm_GA(Info,Instraction, pop)
%% initialization
costfunction=@(q)Cost(q,Info.Model);

NCrossover=2*round((Info.PCrossover*Info.Npop)/2);
NMutation=floor(Info.PMutation*Info.Npop);

NCrossover_Scenario=floor(Info.NCrossover_Scenario*(Info.PScenario3*Info.Npop));
NMutate_Scenario=floor(Info.NMutation_Scenario*(Info.PScenario3*Info.Npop));

individual.Position=[];
individual.Cost=[];
BestCost=[];

%% Initial population

% pop = repmat(individual, Info.Npop, 1);
popc = repmat(individual, NCrossover, 1);
popm = repmat(individual, NMutation, 1);

temp_Scens=[];

% Sort population
[Costs , locatsortedcost]=sort([pop.Cost]);
pop=pop(locatsortedcost);
pop=pop(1:Info.Npop);

% Store Cost
BestSol=pop(1);
WorstCost=pop(end).Cost;
beta=10;         % Selection Pressure (Roulette Wheel)

tic;
%% GA Main loop
for It=1:Info.Iteration

    % Probability for Roulette Wheel Selection
    P=exp(-beta*Costs/WorstCost);
    P=P/sum(P);

    %% Crossover
    for k=1:2:NCrossover

        i1=RouletteWheelSelection(P);
        i2=RouletteWheelSelection(P);

        if isempty(i1)
            i1=randi(Info.Model.Dimension);
        end
        if isempty(i2)
            i2=randi(Info.Model.Dimension);
        end

        pop_(1)=pop(i1);
        pop_(2)=pop(i2);

        [popc(k).Position, popc(k+1).Position]=Crossover(pop_, Info.Crossover_gamma, Info.Model);
 
        % evaluate
        popc(k).Cost = costfunction(popc(k).Position);
        popc(k+1).Cost = costfunction(popc(k+1).Position);
    end

    %% Mutation
    for k=1:NMutation
        popm(k).Position = Mutation(pop(randsample(1:Info.Npop,1)).Position , Info.Mutation_gamma, Info.Model);

        % Evaluation
        popm(k).Cost = costfunction(popm(k).Position);
    end

    %% scenario 1 : Dominated Gen
    if(Instraction(1))
        temp_Scens_1 = repmat(individual, NCrossover_Scenario*2, 1);
        [DominantGenes,~,~]=Analyze(pop(1:(Info.PScenario1*Info.Npop)),Info);
        DominantChromosome.Position = DominantGenes;
        DominantChromosome.Cost = costfunction(DominantChromosome.Position);

        for k=1:2:NCrossover_Scenario*2

            i1=RouletteWheelSelection(P);
            
            if isempty(i1)
                i1=randi(Info.Model.Dimension);
            end

            pop__(1)=DominantChromosome;
            pop__(2)=pop(i1);
            
            [temp_Scens_1(k).Position temp_Scens_1(k+1).Position] = Crossover(pop__, Info.Crossover_gamma, Info.Model);

            % evaluate
            temp_Scens_1(k).Cost = costfunction(temp_Scens_1(k).Position);
            temp_Scens_1(k+1).Cost = costfunction(temp_Scens_1(k+1).Position);
        end
        temp_Scens = [temp_Scens;temp_Scens_1];
    end
    %% scenario 2 : mask mutation in goods
    if(Instraction(2))
        temp_Scens_2 = repmat(individual, NMutate_Scenario, 1);
        [~,Mask,~]=Analyze(pop(1:(Info.PScenario2*Info.Npop)),Info);
        for i=1:NMutate_Scenario
            ii = randsample(1:(Info.PScenario2*Info.Npop),1);
            temp_Scens_2(i).Position = MaskMutation(Info.MaskMutationIndex, pop(randsample(1:(Info.PScenario2*Info.Npop),1)).Position, Mask(ii,:), Info.Model);
            
            % evaluate
            temp_Scens_2(i).Cost = costfunction(temp_Scens_2(i).Position);
        end
        temp_Scens = [temp_Scens;temp_Scens_2];
    end
    %% scenario 3 : inject goods gens
    if(Instraction(3))
        temp_Scens_3 = repmat(individual, NMutate_Scenario, 1);
        [DominantGenes,Mask,~]=Analyze(pop(1:(Info.PScenario3*Info.Npop)),Info);
        for i=1:NMutate_Scenario
            temp_Scens_3(i).Position = CombineQ(DominantGenes, pop(randsample(end-(Info.PScenario3*Info.Npop):end, 1)).Position, Mask, Info.Model);
            temp_Scens_3(i).Cost = costfunction(temp_Scens_3(i).Position);
        end
        temp_Scens = [temp_Scens;temp_Scens_3];
    end
    %% Pool fusion & Selection Best Chromosome

    % Elitism Selection (Npop best will be selected)
    % Create Merged Population
    pop=[pop;popc;popm];
    if size(temp_Scens,1)>1
        pop = [pop;temp_Scens];
    end

    [Costs , locatsortedcost]=sort([pop.Cost]);
    pop=pop(locatsortedcost);
    pop=pop(1:Info.Npop);
    Costs=[pop.Cost];
    BestCost=[BestCost; pop(1).Cost];

    % Show Iteration Information
    disp(['Iteration ' num2str(It)  ', Best Cost = ' num2str(BestCost(It))]);
    
    time = toc;
    if time>=Info.TimeLimit
        break;
    end
end
time;
Ans=pop(1).Cost;
end
