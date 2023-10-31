clc;

center_frequency = 13.56e06;
sampling_rate = 2e+06;
decimation_factor = round(100000000/sampling_rate);
file_name = 'Transmit_Test.bb';
file_path = append('.\Signals\', file_name);

%Create the receiver object
rx = comm.SDRuReceiver(...
                    Platform = "N200/N210/USRP2", ...
                    IPAddress = '192.168.10.2', ...
                    OutputDataType = "double", ...
                    DecimationFactor = decimation_factor, ...
                    Gain = 0, ...
                    CenterFrequency = center_frequency, ...
                    SamplesPerFrame = 1000);

%Create the file writer object
rxWriter = comm.BasebandFileWriter(file_path, ...
    SampleRate=sampling_rate, ...
    CenterFrequency=center_frequency);

%Plot 1 seconds of data, one frame at a time
frameduration = (rx.SamplesPerFrame)/(sampling_rate);
time = 0; 
disp("Reception Started");
while time < 5
  frame = rx();
  rxWriter(frame);
  time = time + frameduration;
end
disp("Reception Stopped");

%Release instances
release(rxWriter);
release(rx);