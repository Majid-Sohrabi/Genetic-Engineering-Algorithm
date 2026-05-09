function Ans=Mutation(p, mu, model, BestSol, current_time, timelimit)

Index = randi([1, 7]);

switch(Index)

    case 1
        Ans=Mutation_Continious(p, mu, model, BestSol, current_time, timelimit);
    case 2
        Ans=Mutation_Random(p, model);
    
    case 3
        Ans = Mutation_Levy(p, model);

    case 4
        Ans=Mutation_Swap(p,model);

    case 5
        Ans=Mutation_Reversion(p,model);

    case 6
        Ans=Mutation_Insertion(p,model);

    case 7
        Ans=Mutation_BigSwap(p,model);
end
end