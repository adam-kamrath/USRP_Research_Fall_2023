function modData = readFrameStartEnd(frameType,modType,fs)
%%
% frameType: 0: start of frame
% frameType: 1: end of frame
% modType: 0: 1 out of 256 mod
% modType: 1: 1 out of 4 mod
% fs: sampling frequency: recommend 13.242 MHz

ts = 1/fs; %unit time

if frameType==0 && modType ==1

    modTime = 75.52*1e-6; % overall time of the modulated data
    modDataLength = round(modTime/ts); % the number of data points in 1 symbol
    modData = zeros(1,modDataLength);

    modData(1:floor(modDataLength/8-1)) = 0.8;
    modData(floor(modDataLength/8):floor(modDataLength/8*5)) = 1;
    modData(floor(modDataLength/8*5+1):floor(modDataLength/4*3-1)) = 0;
    modData(floor(modDataLength/4*3):floor(modDataLength)) = 1;
end

if frameType==1 && modType ==1

    modTime = 37.76*1e-6; % overall time of the modulated data
    modDataLength = round(modTime/ts); % the number of data points in 1 symbol
    modData = zeros(1,modDataLength);

    modData(1:floor(modDataLength/2)) = 1;
    modData(floor(modDataLength/2+1):floor(modDataLength/4*3-1)) = 0;
    modData(floor(modDataLength/4*3):floor(modDataLength)) = 1;
end