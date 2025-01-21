function Ans=RandomSolution(Model) 
   Ans=rand(1,Model.Dimension);   
   Alpha=Model.Max-Model.Min;     
   Ans=Ans.*Alpha;
   Ans=Ans-abs(Model.Min);
end
