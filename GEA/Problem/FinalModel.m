function Ans=FinalModel(Index,Dimension)
if(Index==1)
    Ans.Name = 'Beale';
    Ans.Min = -4.5;
    Ans.Max = 4.5;

elseif(Index==2)
    Ans.Name = 'Easom';
    Ans.Min = -100;
    Ans.Max = 100;

elseif(Index==3)
    Ans.Name = 'Matyas';
    Ans.Min = -10;
    Ans.Max = 10;

elseif(Index==4)
    Ans.Name = 'Colville';
    Ans.Min = -10;
    Ans.Max = 10;

elseif(Index==5)
    Ans.Name='Zakharov';
    Ans.Min=-5;
    Ans.Max=10;

elseif(Index==6)
    Ans.Name='Bohachevsky1';
    Ans.Min=-100;
    Ans.Max=100;

elseif(Index==7)
    Ans.Name='Booth';
    Ans.Min=-10;
    Ans.Max=10;

elseif(Index==8)
    Ans.Name='Michalewicz2';
    Ans.Min=0;
    Ans.Max=pi;

elseif(Index==9)
    Ans.Name='Michalewicz5';
    Ans.Min=0;
    Ans.Max=pi;

elseif(Index==10)
    Ans.Name='Michalewicz10';
    Ans.Min=0;
    Ans.Max=pi;

elseif(Index==11)
    Ans.Name='Schaffer';
    Ans.Min=-100;
    Ans.Max=100;

elseif(Index==12)
    Ans.Name='SixHumpCamelBack';
    Ans.Min = -5;
    Ans.Max = 5;

elseif(Index==13)
    Ans.Name='Boachevsky2';
    Ans.Min=-100;
    Ans.Max=100;

elseif(Index==14)
    Ans.Name='Boachevsky3';
    Ans.Min=-100;
    Ans.Max=100;

elseif(Index==15)
    Ans.Name='Shubert';
    Ans.Min=-10;
    Ans.Max=10;

elseif(Index==16)
    Ans.Name='Step';
    Ans.Min=-5.12;
    Ans.Max=5.12;

elseif(Index==17)
    Ans.Name='Sphere';
    Ans.Min=-100;
    Ans.Max=100;

elseif(Index==18)
    Ans.Name='SumSquares';
    Ans.Min=-10;
    Ans.Max=10;

elseif(Index==19)
    Ans.Name='Quartic';
    Ans.Min=-1.28;
    Ans.Max=1.28;

elseif(Index==20)
    Ans.Name='Schwefell222';
    Ans.Min=-10;
    Ans.Max=10;

elseif(Index==21)
    Ans.Name='Schwefell12';
    Ans.Min=-100;
    Ans.Max=100;

elseif(Index==22)
    Ans.Name='DixonPrice';
    Ans.Min=-10;
    Ans.Max=10;

elseif(Index==23)
    Ans.Name='Rastrigin';
    Ans.Min=-5.12;
    Ans.Max=5.12;

elseif(Index==24)
    Ans.Name='Rosenbrock';
    Ans.Min=-30;
    Ans.Max=30;

elseif(Index==25)
    Ans.Name='Griewank';
    Ans.Min=-600;
    Ans.Max=600;

elseif(Index==26)
    Ans.Name='Ackley';
    Ans.Min=-32;
    Ans.Max=32;
end

% elseif(Index==27)
%     Ans.Name='zakharov';
%     Ans.Min=-5;
%     Ans.Max=10;
% 
% elseif(Index==28)
%     Ans.Name='zakharov';
%     Ans.Min=-5;
%     Ans.Max=10;
% 
% elseif(Index==29)
%     Ans.Name='zakharov';
%     Ans.Min=-5;
%     Ans.Max=10;
% 
% elseif(Index==30)
%     Ans.Name='zakharov';
%     Ans.Min=-5;
%     Ans.Max=10;
% 
% elseif(Index==31)
%     Ans.Name='zakharov';
%     Ans.Min=-5;
%     Ans.Max=10;
% 
% elseif(Index==32)
%     Ans.Name='zakharov';
%     Ans.Min=-5;
%     Ans.Max=10;
% 
% elseif(Index==33)
%     Ans.Name='zakharov';
%     Ans.Min=-5;
%     Ans.Max=10;
% end


Ans.Dimension=Dimension;
end