function [x1 x2]=Crossover_OnePoint(p,model)

    q1=p(1,:);
    q2=p(2,:);

    n=size(p(1,:),2);
    Point=randsample(1:n-1,1);

    x1=[q1(1:Point) q2(Point+1:n)];
    x2=[q2(1:Point) q1(Point+1:n)]; 
end
