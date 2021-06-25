function [Vort] = iBoundary(e1,e2,V1,V2)
Vort = (e1*V1)/(e1+e2)+(e2*V2)/(e1+e2);
end