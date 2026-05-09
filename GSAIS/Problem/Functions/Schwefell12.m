% function z = Schwefell12(x)
% n = numel(x);
% z = 0;
% for i = 1:n
%     z = z + (sum(x(1:i)))^2;
% end
% end

function z = Schwefell12(x)
%SCHEWFELL12 Summary of this function goes here
%   Detailed explanation goes here

z=sum((sum(x).^2));

end

