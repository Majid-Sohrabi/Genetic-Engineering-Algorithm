function q=CombineQ(Position01,Position02,Pattern,Model)
    PatternI=abs(Pattern*-1+ones(1,size(Pattern,2)));
    q=Position01.*Pattern+Position02.*PatternI;
    q;
    
    % Ans.Position=q;
    
    % %%VRP
    % [Ans.Cost Ans.Sol]=MyCost(q,Model);
    
    %%Single Machine
    %Ans.Cost=costfun(q,Model);
    
    %%14 Standard model
    % Ans.Cost=Cost(q,Model);
end
