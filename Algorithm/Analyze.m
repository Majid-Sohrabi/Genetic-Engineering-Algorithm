function [DominantGenes,Mask,DominantChromosome, Mask_Dominant]=Analyze(pop,Info)
%% Data Definition
Npop=size(pop,1);
n=size(pop(1).Position,2);
Ans=zeros(2,n);
Gens=[];
NFixedX=floor(Info.PFixedX*Npop);
Mask=zeros(Info.PScenario1*Info.Npop, n);
pop=ConverC2D(pop,Info.NGap);
%% Find Dominant Gene
row=1;
while(row<=Npop)
    col=1;
    while(col<n)
        row_inner=1;
        temp=0;
        while(row_inner<=Npop)
            if (row==row_inner)
                row_inner=row_inner+1;
                continue
            end

            if (pop(row).Position(1,col) == pop(row_inner).Position(1,col))
                temp=temp+1;
            end
            row_inner=row_inner+1;
        end

        if (temp>=NFixedX)
            Mask(row, col) = 1;
        end
        col=col+1;
    end
    row=row+1;
end

%% Create Ans :
%Dominant
% DominantGenes=Ans(1,:);
count = 0;
Domin = [];
Mask_Dominant = [];
for i=1:Npop
    temp=sum(Mask(i,:)==1);
    % Mask(i,:);
    if (temp>=count)
        if (size(Domin,2)==0)
            Domin=pop(i).Position;
            Mask_Dominant=Mask(i,:);
        else
            decision = rand(1);
            if (decision>0.5)
                Domin=pop(i).Position;
                Mask_Dominant=Mask(i,:);
            end
        end
        count = temp;
    end
end

DominantChromosome.Position=Domin;
% Convert to continuous
DominantGenes = DominantChromosome.Position;
DominantGenes = DominantGenes./Info.NGap;
end
