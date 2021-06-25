clear;
h = 30; iter = 1000;
load ('VoltData.mat'); %% Considered as the data is already calculated

%% Production of The VoltData
% With given variables written above (h,iter), process takes 1204.159 seconds
% (approximately 20 minutes)
% For disallowing unnecessary loss of time,using without the need of a new calculation
% or data loss; using is not advised

tic
[VoltData,ShapeData] = prepareVoltData(h,iter);
save('VoltData.mat','VoltData');
toc


%% Calculation Of Capacity And Electric Field Struct
capacity = zeros(1,h);
eField = zeros(1,h);
for i=0:h
    [capacity(i+1),eField(i+1)] = calculateCapacity(VoltData(:,:,i+1), i);
end
%% Draw Plot
X = capacity;
Y = 0:1:h;
figure

plot(Y,X,'Color',[0,0.7,0.9])

title('Capacity/Depth Plot')
ylabel('Capacity')
xlabel('Depth')

X = eField;
Y = 0:1:h;
figure

plot(Y,X,'Color',[0,0.7,0.9])

title('Electric Field/Depth Plot')
ylabel('Electric Field')
xlabel('Depth')

%% Calculation of Fundamental Statistics of VoltData
sumVolt = zeros (31,1);
sumVolt = sum(sum(VoltData(:,:,1:31)));
sumVolt = sumVolt(:);

meanVolt = zeros(31,1);
meanVolt = mean(mean(VoltData(:,:,1:31)));
meanVolt = meanVolt(:);

X = sumVolt;
Y = 0:1:h;
figure

plot(Y,X,'Color',[0,0.7,0.9])

title('Total Volt in System/Depth Plot')
ylabel('Sum Volt')
xlabel('Depth')

%% Draw Meshgrid

[X,Y] = meshgrid(0.01:.02:1.02, 0.01:.01:1.01);
surf(X,Y,VoltData(:,:,15))
xlabel('X(cm)')
ylabel('Y(cm)')
zlabel('V(Volt)')

%% Extract Features From ShapeData to Set Colors To Each Element
% A - CCFFE5 W - 3333FF N - E0E0E0 M - A0A0A0 
sColors = strings(101,51);
ex = ShapeData(:,:,31);
rArray = zeros(101,51);
bArray = zeros(101,51);
gArray = zeros(101,51);

for i =1:101
    for j=1:51
    if (strcmp(ex(i,j),'A'))
        sColors(i,j) = '#CCFFE5';
    elseif(strcmp(ex(i,j),'W'))
        sColors(i,j) = '#3333FF';
    elseif(strcmp(ex(i,j),'N'))
        sColors(i,j) = '#E0E0E0';
    else
        sColors(i,j) = '#A0A0A0';
    end
    temp = convertStringsToChars(sColors(i,j));
    rgbVal = sscanf(temp(2:end),'%2x%2x%2x',[1 3])/255;
    rArray(i,j) = rgbVal(1);
    bArray(i,j) = rgbVal(2);
    gArray(i,j) = rgbVal(3);
    end
end
%% Create Image Using Extracted RGB Values
imVal = cat(3,rArray,bArray,gArray);
imshow(imVal);




