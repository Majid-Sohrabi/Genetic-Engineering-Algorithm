function x1=Mutation_Swap(q,model)
    n=size(q,2);
    Point=randsample(1:n-1,1);
    q([Point,Point+1])=q([Point+1,Point]);
    x1=q;
end
