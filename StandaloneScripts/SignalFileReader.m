clc;

sampling_rate = 2e+06;
sample_time = 1/sampling_rate;
decimation_factor = 100000000/sampling_rate;

file_name = 'TwoCard_InvRequest.bb';

file_path = append('.\Signals\', file_name);
reader = comm.BasebandFileReader(file_path, SamplesPerFrame=inf);

%Create timescope
time_scope = timescope(SampleRate=sampling_rate);

%Get the data from the file
data = reader();
% plot(abs(data));
%Put data in timescope
time_scope(abs(data));

%Releases
release(reader);
