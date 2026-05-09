function [x1 x2]=Crossover_TwoPoint(p,model)
    
    q1=p(1,:);
    q2=p(2,:);

    n=size(p(1,:),2);
    Point=sort(randsample(1:n-1,2));


    x1=[q2(1:Point(1)) q1(Point(1)+1:Point(2)) q2(Point(2)+1:n)];

    x2=[q1(1:Point(1)) q2(Point(1)+1:Point(2)) q1(Point(2)+1:n)]; 

end
