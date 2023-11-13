function slot = generateSlotData(fs)
%%
% This function will take in the modulated
% data array and return the carrier signals
% to transmit out

sample_time = 1/fs;
slot_time = 4.66e-03;
num_of_samples = round(slot_time/sample_time);
slot = ones(num_of_samples,1);

end