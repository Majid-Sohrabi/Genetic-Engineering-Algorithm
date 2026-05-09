function x1=Mutation_Reversion(q,model)

    n=size(q,2);
    Point=sort(randsample(n,2));
    q(Point(1):Point(2))= q(Point(2):-1:Point(1));
    x1=q;
    
end
