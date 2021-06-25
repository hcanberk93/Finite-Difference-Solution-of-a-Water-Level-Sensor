function [array] = convertStructToArray(x,ival,jval)
array = zeros(ival-1,jval-1);
for i=1:ival-1
    for j=1:jval-1
        array(i,j) = x(i,j).V;
    end
end