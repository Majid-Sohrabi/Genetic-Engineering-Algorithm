function Ans=Cost(Input,Model)

if(strcmp(Model.Name,'Beale'))
    Ans=Beale(Input);

elseif(strcmp(Model.Name,'Easom'))
    Ans=Easom(Input);

elseif(strcmp(Model.Name,'Matyas'))
    Ans=Matyas(Input);

elseif(strcmp(Model.Name,'Colville'))
    Ans=Colville(Input);

elseif(strcmp(Model.Name,'Zakharov'))
    Ans=Zakharov(Input);

elseif(strcmp(Model.Name,'Bohachevsky1'))
    Ans=Bohachevsky1(Input);

 elseif(strcmp(Model.Name,'Booth'))
    Ans=Booth(Input);   

elseif(strcmp(Model.Name,'Michalewicz2'))
    Ans=Michalewicz2(Input);

elseif(strcmp(Model.Name,'Michalewicz5'))
    Ans=Michalewicz5(Input);

elseif(strcmp(Model.Name,'Michalewicz10'))
    Ans=Michalewicz10(Input);

elseif(strcmp(Model.Name,'Schaffer'))
    Ans=Schaffer(Input);

elseif(strcmp(Model.Name,'SixHumpCamelBack'))
    Ans=SixHumpCamelBack(Input);

elseif(strcmp(Model.Name,'Boachevsky2'))
    Ans=Boachevsky2(Input);

elseif(strcmp(Model.Name,'Boachevsky3'))
    Ans=Boachevsky3(Input);

elseif(strcmp(Model.Name,'Shubert'))
    Ans=Shubert(Input);

elseif(strcmp(Model.Name,'Step'))
    Ans=Step(Input);    

elseif(strcmp(Model.Name,'Sphere'))
    Ans=Sphere(Input);

elseif(strcmp(Model.Name,'SumSquares'))
    Ans=SumSquares(Input);

elseif(strcmp(Model.Name,'Quartic'))
    Ans=Quartic(Input);

elseif(strcmp(Model.Name,'Schwefell222'))
    Ans=Schwefell222(Input);

elseif(strcmp(Model.Name,'Schwefell12'))
    Ans=Schwefell12(Input);

elseif(strcmp(Model.Name,'DixonPrice'))
    Ans=DixonPrice(Input);

elseif(strcmp(Model.Name,'Rastrigin'))
    Ans=Rastrigin(Input);

elseif(strcmp(Model.Name,'Rosenbrock'))
    Ans=Rosenbrock(Input);

elseif(strcmp(Model.Name,'Griewank'))
    Ans=Griewank(Input);

elseif(strcmp(Model.Name,'Ackley'))
    Ans=Ackley(Input);

else 
    Ans=Inf;
end
end