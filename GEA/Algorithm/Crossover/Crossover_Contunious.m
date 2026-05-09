function [y1 y2]=Crossover_Contunious(p, gamma, model)
    
    x1 = p(1).Position;
    x2 = p(2).Position;

    VarMin = model.Min;
    VarMax = model.Max;

    zetta=unifrnd(-gamma,1+gamma,size(x1));
    
    y1=zetta.*x1+(1-zetta).*x2;
    y2=zetta.*x2+(1-zetta).*x1;
    
    y1=max(y1,VarMin);
    y1=min(y1,VarMax);
    
    y2=max(y2,VarMin);
    y2=min(y2,VarMax);

end