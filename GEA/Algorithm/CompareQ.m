function Ans=CompareQ(Q1,Q2)
Ans=1;
for i=1:size(Q1,2)
    if(Q1(i)~=Q2(i))
        Ans=0;
        break;
    end
end 
end
