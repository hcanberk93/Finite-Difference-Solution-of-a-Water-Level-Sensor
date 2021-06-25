function [formula] = differentNeigh(x,i,j) %Written algorithm for formula select feature
dot = x(i,j);
left = strcmp(x(i,j-1).surface,dot.surface);
right = strcmp(x(i,j+1).surface,dot.surface);
up = strcmp(x(i-1,j).surface,dot.surface);
down = strcmp(x(i+1,j).surface,dot.surface);

total = left + right + up + down;


if (total == 4)
    formula = "fdr"; %Finite Difference
elseif((total == 3 || total == 1))
    direction = [left,right,up,down];
    if (total == 1) %Will find same one (val=1)
        index = find(direction);
    else  %Total == 3, will find different one (val=0)
        index = find(~direction);
    end
    if (index==1||index==2)
        formula = "lr"; %Left Right
    else 
        formula = "ud"; %Up Down
    end
elseif (total==2)
    if ((up&&down)||(left&&right)==0)
        formula ="crb"; %Cross Boundary
    else                        
        if (left||right)
            formula = "ud";
        else
            formula ="lr";
        end
    end
else %Unused part
    formula = "lr"; %Left Right
end

end