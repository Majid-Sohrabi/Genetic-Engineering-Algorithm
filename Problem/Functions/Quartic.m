function z = Quartic(x)
    %QURATIC Summary of this function goes here
    %   Detailed explanation goes here
    n=numel(x);
    z=0;
    for i=1:n
      z=sum(i*(x(i))^4)+rand+z;  
    end
end

