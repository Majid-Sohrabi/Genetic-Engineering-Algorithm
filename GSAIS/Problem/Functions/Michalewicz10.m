function y=Michalewicz10(x)
    n = length(x);
    sum = 0;
    for ii=1:n
        xi = x(ii);
        new = sin(xi) * (sin(ii*xi^2/pi))^(20);
        sum  = sum + new;
    end
    y = -sum;
end