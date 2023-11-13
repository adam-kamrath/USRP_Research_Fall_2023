clc;

center_frequency = 13560000;
sampling_rate = 2000000;
decimation_factor = round(100000000/sampling_rate);
file_name = 'Amp_Transmit_Test.bb';
file_path = append('.\Signals\', file_name);
time_scope = timescope(SampleRate=sampling_rate);
%Create the receiver object
rx = comm.SDRuReceiver(...
                    Platform = "N200/N210/USRP2", ...
                    IPAddress = '192.168.10.2', ...
                    OutputDataType = "double", ...
                    DecimationFactor = decimation_factor, ...
                    Gain = 0, ...
                    CenterFrequency = center_frequency, ...
                    SamplesPerFrame = 50000);
rx.EnableTimeTrigger = true;
rx.TriggerTime = 5;

%Plot 1 seconds of data, one frame at a time
frameduration = (rx.SamplesPerFrame)/(sampling_rate);
data = [];
time = 0; 
disp("Reception Started");
while time < 5
  frame = rx();
  data = [data, frame];
  time = time + frameduration;
end
disp("Reception Stopped");
data = reshape(data, [], 1);
disp(size(data));
time_scope(abs(data));

%Release instances
release(rx);