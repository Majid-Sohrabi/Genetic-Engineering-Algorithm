function y = Mutation_Continious(x, mu, model, BestSol, current_time, timelimit)

    VarMin = model.Min;
    VarMax = model.Max;

    nVar = numel(x);
    nmu = ceil(mu * nVar);

    j = randsample(nVar, nmu);

    % Time-based adaptation
    progress = min(1, current_time / timelimit);

    % Step size shrinks over time
    sigma = (0.2 * (1 - progress)) .* (VarMax - VarMin) / sqrt(nVar);

    if isscalar(sigma)
        sigma = sigma * ones(1, nVar);   % FIX: expand to vector
    end

    % Directed mutation toward best (GEA-style)
    direction = BestSol.Position - x;

    y = x;

    % Gaussian + directional
    y(j) = x(j) ...
         + sigma(j) .* randn(size(j))' ...
         + (0.2 / sqrt(nVar)) * direction(j);

    % Bounds
    y = max(y, VarMin);
    y = min(y, VarMax);

end