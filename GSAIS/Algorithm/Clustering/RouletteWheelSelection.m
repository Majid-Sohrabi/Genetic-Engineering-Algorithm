function idx = RouletteWheelSelection(probabilities, N)
    cumProb = cumsum(probabilities);
    idx = zeros(N, 1);
    for k = 1:N
        r = rand();
        idx(k) = find(cumProb >= r, 1, 'first');
    end
end