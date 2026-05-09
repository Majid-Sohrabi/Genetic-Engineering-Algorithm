function y=Mutation_Continious(x, mu, model)

    VarMin = model.Min;
    VarMax = model.Max;

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
    j=randsample(nVar,nmu);
    
    sigma=0.1*(VarMax-VarMin);
    
    y=x;
    y(j)=x(j)+(sigma*randn(size(j)));
    
    y=max(y,VarMin);
    y=min(y,VarMax);

end