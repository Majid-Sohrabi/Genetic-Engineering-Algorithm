clc; clear; close all;
%%
addpath('../.');
AddPaths('.././');

%% Parameter
Info.Iteration=1000000;    % Maximum iteration
Info.TimeLimit = 10;        % Maximum time (sec.)

Info.Npop=100;

Info.PCrossover=0.75;
Info.Crossover_gamma=0.5;

Info.PMutation=0.2;
Info.Mutation_gamma=0.05;

Info.NCrossover_Scenario=0.5;
Info.NMutation_Scenario=0.2;

Info.MaskMutationIndex=6;

Info.PFixedX=0.8;
Info.NGap=1000; % n = rate of Continuous to Discrete
Info.PScenario1=0.6;
Info.PScenario2=0.6;
Info.PScenario3=0.6;
Info.Instraction=[1,1,1];

%% Run Ga
index=1;

if index==1
    
    %% Parameter_rewrite
    Repeat=30;

    % Define the function number and dimension
    TestFunction=[1];
    Model_dimension = [2];

    MyStruct.MinCost=[];
    MyStruct.BestCost=[];

    Ans = repmat(MyStruct, Repeat, 4);

    individual.Position=[];
    individual.Cost=[];

    for i=1:length(TestFunction)
        % Extract Model
        Info.Model=FinalModel(TestFunction(i), Model_dimension(i));
        for j = 1:Repeat 
            disp(['Run ' num2str(j)]);
            % Initialize population
            pop = repmat(individual, Info.Npop, 1);

            for init=1:Info.Npop
                pop(init).Position = RandomSolution(Info.Model);
                pop(init).Cost = Cost(pop(init).Position, Info.Model);
            end

            [Ans(j,1).MinCost, Ans(j,1).BestCost, pop_GEA1] = Algorithm_GA(Info, [1,0,0], pop);
            [Ans(j,2).MinCost, Ans(j,2).BestCost, pop_GEA2] = Algorithm_GA(Info, [0,1,0], pop);
            [Ans(j,3).MinCost, Ans(j,3).BestCost, pop_GEA3] = Algorithm_GA(Info, [0,0,1], pop);
            [Ans(j,4).MinCost, Ans(j,4).BestCost, pop_GEA] = Algorithm_GA(Info, [1,1,1], pop);
        end
    end
    save('Saved_Data_Funcitons_Table1_M1');
end