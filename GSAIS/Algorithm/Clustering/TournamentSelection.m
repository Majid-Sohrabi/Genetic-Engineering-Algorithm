function idx = TournamentSelection(costs, k)
    n = numel(costs);
    candidates = randi(n, [1 k]);
    [~, best] = min(costs(candidates));
    idx = candidates(best);
end