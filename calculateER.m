function [errorRate] = calculateER (A,B)
D = abs(A-B);
errorRate = sqrt(sum(D.*D))/ sqrt(sum(B.*B)); ;
end
