%% Experiment GSAIS-KMeans

close all;
clear all;
clc;

%% Add path & Address manage
addpath('../.');
AddPaths('.././');

%% Parameter
Info.Iteration=100000000;    % Maximum iteration
Info.TimeLimit = 10;        % Maximum time (sec.)

% Noise proportion for regeneration
Info.regenerate = 0.1;

Info.Npop=100;  % Population size

Info.PCrossover=0.75;   % Crossover probability
Info.Crossover_gamma=0.5;

Info.PMutation=0.2;
Info.Mutation_gamma=0.05;

Info.cluster_sizes=max(2, round(sqrt(Info.Npop / 2)));    % Number of clusters
Info.alpha_eps=0.55;
Info.MinPts=2;
Info.alpha=0.25;
Info.gamma=0.33;

%% Run Ga
index=1;

if index==1
    
    %% Parameter_rewrite
    
    Repeat=30;

    TestFunction=[1];
    Model_dimension = [2];

    MyStruct.MinCost=[];
    MyStruct.BestCost=[];
    Ans = repmat(MyStruct, Repeat, 1);

    individual.Position=[];
    individual.Cost=[];

    for i=1:length(TestFunction)
        % Extract Model
        Info.Model=FinalModel(TestFunction(i), Model_dimension(i));
        for j = 1:Repeat 
            % disp(['Run ' num2str(j)]);
            % Initialize population
            pop = repmat(individual, Info.Npop, 1);

            for init=1:Info.Npop
                pop(init).Position = RandomSolution(Info.Model);
                pop(init).Cost = Cost(pop(init).Position, Info.Model);
            end

            % Generate the pop_random
            pop_random = repmat(individual, Info.Npop * Info.regenerate, 1);
            for init=1:round(Info.Npop * Info.regenerate)
                pop_random(init).Position = RandomSolution(Info.Model);
                pop_random(init).Cost = Cost(pop_random(init).Position, Info.Model);
            end
            
            [Ans(j,1).MinCost, Ans(j,1).BestCost, pop_GSAIS] = Algorithm_GSAIS_DBSCAN_Benchmark(pop, Info, pop_random);
            
        end
    end
    save('Saved_Data_GSAIS_Funcitons_Table1_M1');
end