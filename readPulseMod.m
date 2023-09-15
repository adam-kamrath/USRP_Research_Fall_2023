function modData = readPulseMod(modType, fs, data)

%%
% modType: 0: 1 in 256 for slow data rate
%          1:  1 in 4 for fast data rate
% fs: sample frequency: recommend 13.242 MHz
% data: binary data to be modulated

ts = 1/fs; %unit time

dataLength = length(data);

if modType == 1

    modTime = dataLength/2*75.52*1e-6; % overall time of the modulated data
    symbolDataLength = round(75.52*1e-6/ts); % the number of data points in 1 symbol
    modDataLength = symbolDataLength*dataLength/2; % the number of data points need to be returned
    modData = zeros(1,modDataLength);

    for i = 1:1:dataLength/2

        if data(2*i-1)==0 && data(2*i)==0
            startData = (i-1)*symbolDataLength;
            modData(floor(1+startData):floor(symbolDataLength/8+startData)) = 1;
            modData(floor(symbolDataLength/8+startData+1):floor(symbolDataLength/4+startData-1)) = 0;
            modData(floor(symbolDataLength/4+startData):floor(symbolDataLength+startData)) = 1;
        end

        if data(2*i-1)==0 && data(2*i)==1
            startData = (i-1)*symbolDataLength;
            modData(floor(1+startData):floor(symbolDataLength/8*3+startData)) = 1;
            modData(floor(symbolDataLength/8*3+startData+1):floor(symbolDataLength/2+startData-1)) = 0;
            modData(floor(symbolDataLength/2+startData):floor(symbolDataLength+startData)) = 1;
        end


        if data(2*i-1)==1 && data(2*i)==0
            startData = (i-1)*symbolDataLength;
            modData(floor(1+startData):floor(symbolDataLength/8*5+startData)) = 1;
            modData(floor(symbolDataLength/8*5+startData+1):floor(symbolDataLength/4*3+startData-1)) = 0;
            modData(floor(symbolDataLength/4*3+startData):floor(symbolDataLength+startData)) = 1;
        end

        if data(2*i-1)==1 && data(2*i)==1
            startData = (i-1)*symbolDataLength;
            modData(floor(1+startData):floor(symbolDataLength/8*7+startData)) = 1;
            modData(floor(symbolDataLength/8*7+startData+1):floor(symbolDataLength+startData)) = 0;
        end
    end

end
