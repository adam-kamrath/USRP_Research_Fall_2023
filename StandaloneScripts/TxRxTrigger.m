center_frequency = 13560000;
sampling_rate = 2000000;
decimation_factor = round(100000000/sampling_rate);

time_scope = timescope(SampleRate=sampling_rate);

%Create the receiver object
rx = comm.SDRuReceiver(...
                    Platform = "N200/N210/USRP2", ...
                    IPAddress = '192.168.10.2', ...
                    OutputDataType = "double", ...
                    DecimationFactor = decimation_factor, ...
                    Gain = 0, ...
                    CenterFrequency = center_frequency, ...
                    SamplesPerFrame = 1000);

rx.EnableTimeTrigger = true;
rx.EnableTimeTrigger = 5;

 %% set up transmitter radio
            tx = comm.SDRuTransmitter(Platform = "N200/N210/USRP2", ...
                IPAddress =  '192.168.10.3', ...
                CenterFrequency = 13.56*1e6, ...
                Gain = 0, ...
                MasterClockRate = 100*1e6, ...
                InterpolationFactor = InterpolationFactor);