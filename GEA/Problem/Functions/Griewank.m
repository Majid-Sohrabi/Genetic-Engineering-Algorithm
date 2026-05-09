function z = Griewank(x)
%GREIWANK Summary of this function goes here
%   Detailed explanation goes here
n=numel(x);
z=0;
for i=1:n
    z=x(i).^2+z;
end
z=z*(1/4000);
for i=1:n
    z=-cos(x(i)/sqrt(i))+z;
end
z=z+1;
z=abs(z);
end

