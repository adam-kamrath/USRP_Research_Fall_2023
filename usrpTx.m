clc;
time_scope = timescope();
%binaryStr = hexToBinaryVector('88E80000000000000000DD63');
binaryStr = hexToBinaryVector('9040007360');
modData = [];

fs = 25*10^6;
for i = 1:1:length(binaryStr)/2
    modSymbol = readPulseMod(1, fs, binaryStr(((i-1)*2+1):(i*2)));
    modData=[modData,modSymbol];
end


sof = readFrameStartEnd(0,1,fs);
eof = readFrameStartEnd(1,1,fs);

modData = [sof,modData,eof];
modData = modData';
carrier1 = ones(length(modData)*30,1);
carrier0 = zeros(length(modData)*30,1);

Tb = 0.0001;
nb = 100;
N = length(modData);
Ac1 = 12;     % Carrier amplitude for binary input '1'
Ac2 = 5;      % Carrier amplitude for binary input '0'
br = 1/Tb;    % Bit rate
Fc = br*10;   % Carrier frequency 
t2 = Tb/nb:Tb/nb:Tb;   % Signal time             
mod = [];
for (i = 1:1:N)
    if (modData(i) == 1)
        y = Ac1*cos(2*pi*Fc*t2);   % Modulation signal with carrier signal 1
    else
        y = Ac2*cos(2*pi*Fc*t2);   % Modulation signal with carrier signal 2
    end
    mod = [mod y];
end
time_scope(mod')
% 
% %% set up usrp
% connectedRadios = findsdru;
% if strncmp(connectedRadios(1).Status, 'Success', 7)
%     platform = connectedRadios(1).Platform;
% 
%     address = connectedRadios(1).IPAddress;
% 
% end
% compileIt  = true; % true if code is to be compiled for accelerated execution
% useCodegen = true; % true to run the latest generated mex file
% 
% radio = comm.SDRuTransmitter(Platform = "N200/N210/USRP2", ...
%     IPAddress =  '192.168.10.3', ...
%     CenterFrequency = 13.56*1e6, ...
%     Gain = 80, ...
%     MasterClockRate = 100*1e6, ...
%     InterpolationFactor = 4);
% disp("Transmitting!");
% for i = 1:1:200
%     radio([carrier0;carrier1;modData;carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1;eof';carrier1;eof';...
%         carrier1]);
% end
% disp("Done Transmitting!");
% release(radio);