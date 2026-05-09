function y=Shubert(x)
    f1 = 0;
    f2 = 0;
    for j = 1:5
        f1 = f1 + j .* cos((j + 1).* x(1) + j);
        f2 = f2 + j .* cos((j + 1).* x(2) + j);
    end
    y = f1 .* f2;
end