function Ans=Mutation(p, mu, model)

Index = randi([1, 2]);

switch(Index)

    case 1
        Ans=Mutation_Continious(p, mu, model);
    case 2
        Ans=Mutation_Random(p, model);
end
end