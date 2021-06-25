function [Volt] = crossBoundary(x,i,j)
e1 = x(i-1,j+1).eps; %Upper Right
e2 = x(i+1,j+1).eps;
e3 = x(i-1,j-1).eps;
e4 = x(i+1,j-1).eps;
Vup = x(i-1,j).V;
Vdown = x(i+1,j).V;
Volt = ((e1+e3)*Vup + (e4+e2)*Vdown)/(e1+e2+e3+e4);
end