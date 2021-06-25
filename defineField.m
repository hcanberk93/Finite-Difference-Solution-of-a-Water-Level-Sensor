%Defined for 200 row 100 column (20x10 br shaped) can
%Eps values are taken from related documents written below
%https://www.engineeringtoolbox.com/relative-permittivity-d_1660.html
%https://www.vega.com/-/media/pdf-files/list_of_dielectric_constants_en.pdf
%Used Materials
%A - Air - eps: 1.000536 (Dry - 68 F)
%M - Aluminium Foil eps: 10.8
%N - Nylon - eps: 4
%W - Water - eps: 88 (32 F)

function [result] = defineField (defField,depth)
result = defField;
result = defineAir(result);

aH = size(result,1); %Area Height
aW = size(result,2); %Area Width

%Define Metal Can
for i=20:aH
result(i,1).surface ='M';
result(i,1).eps = 10.8;
result(i,1).V = 0;

result(i,aW).surface ='M';
result(i,aW).eps = 10.8;
result(i,aW).V = 0;
end

for i=1:aW 
result(aH,i).surface ='M';
result(aH,i).eps = 10.8;
result(aH,i).V = 0;
end

for i=40:aH-1 %Define Water
    for j=2:aW-1
        result(i,j).surface ='W';
        result(i,j).eps = 88;
        result(i,j).V = 0;
    end
end

%Define Nylon Bag
%x-11,41 y-9,39 

for i=9+depth:39+depth
    for j=11:41
        result(i,j).surface = 'N';
        result(i,j).eps = 4;
        result(i,j).V = 0;
    end
end

for i=9+depth:31+depth
    for j=19:33
        result(i,j).surface = 'M';
        result(i,j).eps = 10.8;
        result(i,j).V = 1;
    end
end
    
  

end

function [canOfAir] = defineAir(can)
for i=1:size(can,1)
    for j=1:size(can,2)
        can(i,j).surface ='A';
        can(i,j).eps = 1.000536;
        can(i,j).V = 0;
    end
end
canOfAir = can;
end