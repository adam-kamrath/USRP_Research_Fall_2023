function [modData, sof, eof] = modulateHexString(hexSequence,fs, ask_percent)
%%
% This function takes in a string of hex values
% example: 'A02D3F6C' and returns out the modulated
% data array to transmit out

binaryStr = hexToBinaryVector(hexSequence);
modData = [];

for i = 1:1:length(binaryStr)/2
    modSymbol = generatePulseData(1, fs, binaryStr(((i-1)*2+1):(i*2)), ask_percent);
    modData=[modData,modSymbol];
end

sof = generateFrameStartEnd(0,1,fs,ask_percent);
eof = generateFrameStartEnd(1,1,fs,ask_percent);

modData = [sof, modData, eof];
end