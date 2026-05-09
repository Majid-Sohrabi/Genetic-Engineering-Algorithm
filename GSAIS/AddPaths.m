function AddPaths(Str)
%% Algorithm directory
addpath([Str , 'Algorithm']);
addpath([Str , 'Algorithm/Clustering']);
addpath([Str , 'Algorithm/Crossover']);
addpath([Str , 'Algorithm/Mutation']);

%% Problem directory
addpath([Str , 'Problem']);
addpath([Str , 'Problem/Functions']);

end
