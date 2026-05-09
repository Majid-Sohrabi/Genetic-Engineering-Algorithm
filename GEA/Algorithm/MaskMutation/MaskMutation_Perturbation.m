function q=MaskMutation_Perturbation(q,mask,Model)

VarMin = Model.Min;
VarMax = Model.Max;

maskPosition=find(~mask);
if(size(maskPosition,2)~=0)
    Point=randsample(maskPosition,1);

    sigma=0.1*(VarMax-VarMin);

    q(Point)=q(Point)+(sigma*randn(size(Point)));

    % Fix to the range of Min and Max
    q(Point) = max(q(Point), Model.Min);
    q(Point) = min(q(Point), Model.Max);

end
q;
end
