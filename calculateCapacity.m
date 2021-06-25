%Aluminium Coordinates: x:[19,33] y:[9+depth,31+depth]
function [capacity,Etotal] = calculateCapacity(x,depth)
dx = 8^-1;dy = 8^-1;l = 31;
Eside = 0;Eup = 0;Edown = 0;
epsN = 4;epsA=1.000536;
eO = 8.85*10^-12;

for i=9+depth:31+depth
Eside = Eside + (abs(x(i,19)-x(i,18))/dx);
Eside = Eside + (abs(x(i,33)-x(i,34))/dx);
end
Qside = Eside*epsN*dy*l;

for i=19:33
Eup = Eup + (abs(x(9+depth,i)-x(8+depth,i))/dy);
Edown = Edown + (abs(x(31+depth,i)-x(32+depth,i))/dy);
end

Qup = epsA*Eup*dx*l;
Qdown = epsN*Edown*dx*l;
Etotal = Eup + Edown+ Eside;
capacity = (Qside + Qup + Qdown)*eO;

end