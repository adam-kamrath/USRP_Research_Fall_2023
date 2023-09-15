%%
% This function will take in a sequence of
% modulated data and add a start of frame
% or end of frame to it, then return the
% new array of data

function frame = generateFrameStartEnd(frameType,modType,fs)

%%
% frameType: 0: start of frame
% frameType: 1: end of frame
% modType: 0: 1 out of 256 mod
% modType: 1: 1 out of 4 mod
% fs: sampling frequency: recommend 13.242 MHz

ts = 1/fs; %unit time

% Adds a 1 out of 4 start of frame to data 
if frameType==0 && modType ==1

    frameTime = 75.52e-06; % overall time of the modulated data
    frameDataLength = round(frameTime/ts); % the number of data points in 1 symbol
    frame = zeros(1,frameDataLength);
    disp(frameDataLength);

    frame(1:floor((frameDataLength/8)-1)) = 0;
    frame(floor(frameDataLength/8):floor(frameDataLength/8*5)) = 1;
    frame(floor(frameDataLength/8*5+1):floor(frameDataLength/4*3-1)) = 0;
    frame(floor(frameDataLength/4*3):floor(frameDataLength)) = 1;
end

%Adds a 1 out of 4 end of frame to data
if frameType==1 && modType ==1

    frameTime = 37.76*1e-6; % overall time of the modulated data
    frameDataLength = round(frameTime/ts); % the number of data points in 1 symbol
    frame = zeros(1,frameDataLength);

    frame(1:floor(frameDataLength/2)) = 1;
    frame(floor(frameDataLength/2+1):floor(frameDataLength/4*3-1)) = 0;
    frame(floor(frameDataLength/4*3):floor(frameDataLength)) = 1;
end

% Adds a 1 out of 256 start of frame to data 
if frameType==0 && modType ==0

    frameTime = 75.52*1e-6; % overall time of the modulated data
    frameDataLength = round(frameTime/ts); % the number of data points in 1 symbol
    frame = zeros(1,frameDataLength);

    frame(1:floor(frameDataLength/8-1)) = 0;
    frame(floor(frameDataLength/8):floor(frameDataLength/8*7)) = 1;
    frame(floor(frameDataLength/8*7+1):floor(frameDataLength)) = 0;
end

%Adds a 1 out of 256 end of frame to data
if frameType==1 && modType ==0

    frameTime = 37.76*1e-6; % overall time of the modulated data
    frameDataLength = round(frameTime/ts); % the number of data points in 1 symbol
    frame = zeros(1,frameDataLength);

    frame(1:floor(frameDataLength/2)) = 1;
    frame(floor(frameDataLength/2+1):floor(frameDataLength/4*3-1)) = 0;
    frame(floor(frameDataLength/4*3):floor(frameDataLength)) = 1;
end