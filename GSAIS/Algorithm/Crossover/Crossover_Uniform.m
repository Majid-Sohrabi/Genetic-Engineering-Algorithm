function [y1, y2] = Crossover_Uniform(p, model)

    x1 = p(1,:);
    x2 = p(2,:);

    VarMin = model.Min;
    VarMax = model.Max;

    n = numel(x1);

    % Generate random binary mask
    mask = randi([0 1], 1, n);

    % Initialize children
    y1 = x1;
    y2 = x2;

    % Swap based on mask
    idx = (mask == 0);

    y1(idx) = x2(idx);
    y2(idx) = x1(idx);

    % Apply bounds (same as your continuous crossover)
    y1 = max(y1, VarMin);
    y1 = min(y1, VarMax);

    y2 = max(y2, VarMin);
    y2 = min(y2, VarMax);

end
