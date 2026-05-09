function [Ans1 Ans2]=Crossover(p, gamma, model)
    
    Index = 1;

    if(Index==1)
        [Ans1 Ans2] = Crossover_Contunious(p, gamma, model);
    end
end

