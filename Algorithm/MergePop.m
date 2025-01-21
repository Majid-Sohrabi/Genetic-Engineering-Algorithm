function Ans=MergePop(pop,NGap) 
TempPop=ConverC2D(pop,NGap);
n=size(TempPop,1);
AnsIndex=1;
for i=n:-1:2
    temp=1;
    for j=i-1:-1:1        
        if(CompareQ(TempPop(i).Position,TempPop(j).Position))
            temp=0;
            j=1;
        end
    end
    if(temp)
        AnsIndex=[AnsIndex,i];
    end
end
Ans=pop(AnsIndex);
end