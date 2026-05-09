function pop=ConverC2D(pop,NGap)

% pop = [2.61225086	-82.1437181	52.75669484	-22.3213376	-70.43152089;68.38290017	30.89121543	21.58757616	-4.508831817	22.31578071;-83.60257937	8.603433958	-35.57605948	-51.12332006	-95.5347093;2.61226111	51.3309273	1.405062971	23.00980381	-19.58347721;15.23539045	52.53509692	23.78798539	-37.04345759	60.31886864;-54.21890602	-72.09226015	14.94933401	28.43686563	-50.19382114];
% NGap = 1000;

%Conver Continuous Choromosome to Discrete
npop=size(pop,1);
n=size(pop(1).Position,2);
% n=5;
Interval=1/NGap;
for i=1:npop
    for j=1:n
        pop(i).Position(j)=floor((pop(i).Position(j))/Interval)+1;
        % pop(i,j) = floor((pop(i,j))/Interval)+1;
    end
end
end