function Ans = MaskMutation(Index,q,mask,Model)
Index = 1;
switch(Index)
    case 1
        Ans = MaskMutation_Perturbation(q, mask, Model);  
end
end
