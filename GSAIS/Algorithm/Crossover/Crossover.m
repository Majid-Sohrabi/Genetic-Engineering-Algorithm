function [Ans1 Ans2]=Crossover(p, gamma, model, popMatrix)
    
    n=size(p,2);
    if n < 8
        Index = randi([1, 4]);
    else
        Index = randi([1, 5]);
    end

    if(Index==1)
        [Ans1 Ans2] = Crossover_Contunious(p, gamma, model);

    elseif (Index==2)
        [Ans1 Ans2]=Crossover_Uniform(p,model);
    
    elseif (Index==3)
        [Ans1 Ans2]=Crossover_Differential(p, popMatrix, model);

    elseif(Index==4)
        [Ans1 Ans2]=Crossover_OnePoint(p,model);

    elseif (Index==5)
        [Ans1 Ans2]=Crossover_TwoPoint(p,model);
    
    end
end

