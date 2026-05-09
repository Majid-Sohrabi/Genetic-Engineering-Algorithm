function AddPaths(Str)
%% Algorithm directory
addpath([Str , 'Algorithm']);
addpath([Str , 'Algorithm/Crossover']);
addpath([Str , 'Algorithm/MaskMutation']);
addpath([Str , 'Algorithm/Mutation']);
addpath([Str , 'Algorithm/ICAFunctions']);

%% Problem directory
addpath([Str , 'Problem']);
addpath([Str , 'Problem/Functions']);
end
