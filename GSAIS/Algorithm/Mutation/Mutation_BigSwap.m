function x1=Mutation_BigSwap(q,model)
    n=size(q,2);
    Point=randsample(1:n,2);
    q([Point(1),Point(2)])=q([Point(2),Point(1)]);
    x1=q;
end
