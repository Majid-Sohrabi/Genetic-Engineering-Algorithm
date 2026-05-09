function x1=Mutation_Random(q, model)
    n=size(q,2);
    
    VarMin = model.Min;
    VarMax = model.Max;

    % For chromosomes length less than 10, just mutate one gene
    if n>10
        num_rand=randi([1 5]);
    else
        num_rand=1;
    end
    %  Reduce randomness intensity

    Point = randsample(1:n, num_rand);

    for i=1:num_rand
        r1=unifrnd(VarMin, VarMax, 1);
        q(Point(i))=r1;
    end

    x1 = q;
end
