clc;

center_frequency = 14.01e06;
sampling_rate = 2e+06;
decimation_factor = round(100000000/sampling_rate);
file_name = 'DistanceTest.bb';
file_path = append('.\Signals\', file_name);

%Create the receiver object
rx = comm.SDRuReceiver(...
                    Platform = "N200/N210/USRP2", ...
                    IPAddress = '192.168.10.2', ...
                    OutputDataType = "double", ...
                    DecimationFactor = decimation_factor, ...
                    Gain = 3, ...
                    CenterFrequency = center_frequency, ...
                    SamplesPerFrame = 500000);

%Create the file writer object
rxWriter = comm.BasebandFileWriter(file_path, ...
    SampleRate=sampling_rate, ...
    CenterFrequency=center_frequency);

%Create Time Scope object
time_scope = timescope(SampleRate=sampling_rate, Position=[1000,100,800,350]);

%Plot 1 seconds of data, one frame at a time
disp("Reception Started");
frameduration = (rx.SamplesPerFrame)/(sampling_rate);
time = 0; 
while time < 4
  frame = rx();
  rxWriter(frame);
  time_scope(frame)
  time = time + frameduration;
end
disp("Reception Stopped");

%Release instances
release(rxWriter);
release(time_scope); 
release(rx);