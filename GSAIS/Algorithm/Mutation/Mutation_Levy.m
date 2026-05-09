function y = Mutation_Levy(x, model)

    VarMin = model.Min;
    VarMax = model.Max;

    nVar = numel(x);

    beta = 1.5;  % Levy parameter

    % Levy distribution
    sigma = (gamma(1+beta)*sin(pi*beta/2) / ...
            (gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);

    u = randn(1,nVar) * sigma;
    v = randn(1,nVar);
    step = u ./ abs(v).^(1/beta);

    % Scale step size
    alpha = 0.01 * (VarMax - VarMin);

    y = x + alpha .* step;

    % Bound handling
    y = max(min(y, VarMax), VarMin);

end