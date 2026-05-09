function z = Schwefell222(x)
% SCHEWFELL222 Summary of this function goes here
%   Detailed explanation goes here
n=numel(x);
z=0;
for i=1:n
    z=sum(abs(x(i)))+prod(abs(x(i)))+z;
end

