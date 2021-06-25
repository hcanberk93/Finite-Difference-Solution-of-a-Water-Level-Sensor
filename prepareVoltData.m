function [VoltData,ShapeData] = prepareVoltData(h,iter)

Mkap(101,51) = struct('surface',' ','V',0,'eps',0);

VoltData = zeros(101,51,h);
ShapeData = repmat(' ',101,51,h);


for depth=0:h
Mkap = defineField (Mkap,depth);


for it=1:iter %iteration
errorRate = 1;
    
for i=2:100
    for j=2:50
        
        if (strcmp(Mkap(i,j).surface,"M"))
            %Const Points
            continue;
        else
            % 40th row is the beginning of the water medium in the metal can
            % At (39,2),(40,2),(39,50) and (40,50), interface boundary rule
            % should be applied
            % For the rest of the edge points, finite difference formula
            % is implemented
            boundaryCondition = ((j==2||j==50)&&(i~=39&&i~=40));
            if(boundaryCondition) 
                formula ="fdr";
            else
                formula = differentNeigh(Mkap,i,j);
            end
            
            
         if (formula == "ud")
            Mkap(i,j).V =  iBoundary(Mkap(i-1,j).eps,Mkap(i+1,j).eps,Mkap(i-1,j).V,Mkap(i+1,j).V);
         elseif (formula == "lr")
            Mkap(i,j).V =  iBoundary(Mkap(i,j-1).eps,Mkap(i,j+1).eps,Mkap(i,j-1).V,Mkap(i,j+1).V);
         elseif(formula =="crb")
            Mkap(i,j).V = crossBoundary(Mkap,i,j);
         else
            Mkap(i,j).V = fDifference (Mkap(i,j-1).V,Mkap(i,j+1).V,Mkap(i-1,j).V,Mkap(i+1,j).V);
        end
        end
        
        if ((i>=2&&i<=19)) %Neumann Condition
           % Metal Can starts from 20th row index
           % In air medium, Neumann Boundary Condition is applied.
           % Checking row indexes range between 2nd and 20th would be
           % useful in this condition
           if(j==2)
                Mkap(i,j-1).V = Mkap(i,j).V;
           elseif(j==50)
                Mkap(i,j+1).V = Mkap(i,j).V;
           end
           if(i==2)
               Mkap(i-1,j).V = Mkap(i,j).V;
           end
           
        end
        
    end
end
%Calculation of the Error Rate Between Per Iteration
if (it == 1)
    B = convertStructToArray(Mkap,101,51);
else
    A = B;
    B = convertStructToArray(Mkap,101,51);
    errorRate = calculateER(A,B);
end

if (errorRate <= 0.005)
    disp(it);
    break;

end

for i=1:101
    for j=1:51
        VoltData(i,j,depth+1) = Mkap(i,j).V;
        ShapeData(i,j,depth+1) = Mkap(i,j).surface;
    end
end


end

end