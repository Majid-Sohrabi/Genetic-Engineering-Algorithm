function [y1, y2] = Crossover_Differential(p, pop, model)

    x1 = p(1,:);
    x2 = p(2,:);

    VarMin = model.Min;
    VarMax = model.Max;

    nVar = numel(x1);

    % Select two random individuals from population
    idx = randperm(size(pop,1), 2);
    xr1 = pop(idx(1), :);
    xr2 = pop(idx(2), :);

    % Scale factor (adaptive)
    F = 0.5 + 0.3 * rand;

    % Subspace mask (important!)
    CR = 0.3;  % crossover rate
    mask = rand(1,nVar) < CR;

    y1 = x1;
    y2 = x2;

    % Apply DE-style update only on subset
    y1(mask) = x1(mask) + F * (xr1(mask) - xr2(mask));
    y2(mask) = x2(mask) + F * (xr2(mask) - xr1(mask));

    % Bound control
    y1 = max(min(y1, VarMax), VarMin);
    y2 = max(min(y2, VarMax), VarMin);

end